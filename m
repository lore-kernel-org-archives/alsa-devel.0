From: Bill Kapralos <billk@cs.yorku.ca>
Subject: Re: Question Regarding Simple ALSA Stereo Output
Date: Wed, 23 Jun 2004 11:04:48 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406231057040.6839@blue.cs.yorku.ca>
References: <Pine.HPX.4.33n.0406231640060.16948-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406231640060.16948-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens

Thanks for the prompt response!

Should have mentioned this in the original email however I am using an SGI
"box" wit dual Pentium III processors running SuSe Linux with a
(VT82C686 ACER AC97 Audio Controller).  The card does support stereo and I
can successfully set the number of channels to two (using
snd_pcm_hw_params_set_channels() ).  After adding the code you suggested,
the following was output:

 stream       : PLAYBACK
 access       : RW_INTERLEAVED
 format       : S16_LE
 subformat    : STD
 channels     : 2
 rate         : 44100
 exact rate   : 44100 (44100/1)
 msbits       : 16
 buffer_size  : 20480
 period_size  : 2048
 period_time  : 46438
 tick_time    : 10000

Once again, thanks for the response!

Regards,

================================================

On Wed, 23 Jun 2004, Clemens Ladisch wrote:

> Bill Kapralos wrote:
> > It appears as if it is simply outputting the data assuming one
> > channel e.g. the same signal is heard in both the left and right
> > ear even when I have deliberately made the signals different (e.g.
> > introduced a considerable delay to one channel etc.). Furthermore,
> > when I explicitly set all left channel samples to "0" and the
> > right channel samples to "non-zero", no sound is heard at all - it
> > seems as if only the left channel data is being output which is of
> > course all zero.  In contrast, if i set all the right channel
> > samples to zero and the left channel samples to non-zero, the
> > sound is heard.
>
> Does the function snd_pcm_hw_params_set_channels() return an error?
>
> What is output when you add the following code after the call to
> snd_pcm_hw_params():
>
> 	snd_output_t *out;
> 	...
> 	snd_output_stdio_attach(&out, stdout, 0);
> 	snd_pcm_dump_hw_setup(pcm, out);
> 	snd_output_close(out);
>
> What hardware do you use?
>
>
> Regards,
> Clemens
>
>
>


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
