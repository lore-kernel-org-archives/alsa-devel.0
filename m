From: James Courtier-Dutton <James@superbug.co.uk>
Subject: A suggestion for better resamplers in alsa.
Date: Fri, 01 Apr 2005 21:58:57 +0100
Message-ID: <424DB611.9000009@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a idea for how we might solve the current resampler problem in alsa.
The current problem is that the resampling is done per period, but the
period size of the application is not always an integer of the hardware
period size. e.g. If the hardware does 48000 Hz and one sets a hardware
period size of 1024. If the application is running at 44100 Hz, the
applications period size will be 940.8, but the period cannot be a
non-integer, so we probably get 940 instead.
One alternative is to have the application's period size vary, so
sometimes it is 940 and other times it is 941. Even with this, the
current resampler code will try to expand 940 samples into 1024, or 941
samples into 1024. Neither of these is perfect. What we really need is
for a given number of input samples, resample to a varying number of
output samples depending on the current sample rate converters filter
history or be pre-warned, at each write, how many application samples
will fill the 1024 hardware period.
Application's runing at 44100 Hz and hardware runing at 48000 Hz is very
common(mp3, CDs) so we really need to find a good solution to this.

The code of interest is:
snd_pcm_sframes_t snd_pcm_mmap_writei(snd_pcm_t *pcm, const void
*buffer, snd_pcm_uframes_t size)
{
        snd_pcm_channel_area_t areas[pcm->channels];
        snd_pcm_areas_from_buf(pcm, areas, (void*)buffer);
        return snd_pcm_write_areas(pcm, areas, 0, size,
                                   snd_pcm_mmap_write_areas);
}

1) If we could get the sample rate conversion done in the
snd_pcm_areas_from_buf() function, we could quite happily vary the
number of output samples from the sample rate converter, ready for
sending to the snd_pcm_write_areas() function.

2) Another solution would be to re-write the snd_pcm_write_areas
function so that it can write samples, but the call would be a multi
stage operation.
I.e. First call a function that returns a value containing the number of
application samples that will be consumed in order to write
1024(hardware period size) samples. This value returned will change
depending on resampler filter history.
The next function will then send exactly the correct number of samples
to the sample rate converter.
The write_areas function tries to write samples one period at a time, so
this (2) option should work quite well. The only disadvantage is that we
will probably have to change the plugin api to acheive this. :-(
As this effectively changes the application period size on each write
operation, we might have to also feed this information back up to the
application for applications that reply on being able to write exactly
one period at a time to the sound card.

In order to port high quality sample rate converts to alsa, I suggest
that we implement it in alsa-lib as floating point operations first.
Once that has been bug fixed, we can then write separate accelerated
interger versions of it. I have found that the rate converters do not
work at all well for 24bit sound samples currently. I.e. Sending 44.1
Khz S32_LE audio to the P16V chip, so it has to get resampled to 48khz
S32_LE first. One just hears horrible noises output.

Any comments?

James



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
