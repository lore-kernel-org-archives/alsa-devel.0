From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: OSS SNDCTL_DSP_GETISPACE, non-blocking read: messy :-\
Date: Sat, 25 Oct 2003 22:02:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031025200221.GA6415@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi all,

RAT (Robust Audio Tool, http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/)
shows quite miserable behaviour on ALSA/OSS (current CVS):

andi@note:/home/andi$ rat 193.8.230.138/2074
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
audio_read: Resource temporarily unavailable
.
.
.
andi@note:/home/andi$

I've been analyzing the reason for about 1.5 hours now,
and I guess I know what the problem is, but I'm uncertain as to how it should
be fixed (I could probably fix it, but I REALLY want to leave it to much more
experienced people since I'm afraid that code is VERY easy to break...).

Our SNDCTL_DSP_GETISPACE implementation in alsa-driver/acore/oss/pcm_oss.c
calls snd_pcm_oss_get_space(), which returns the number of bytes available
to read (e.g. 224).

RAT then does a read() with exactly this amount of bytes.

The read() causes alsa-kernel/core/oss/pcm_oss.c/snd_pcm_oss_read()
to be called, with this amount of bytes passed.

This now calls snd_pcm_oss_read1(), with the bytes set to the same amount
again.

For some stupid reason, _read1() now ALWAYS calls into snd_pcm_oss_read2()
with an amount of runtime->oss.period_bytes bytes to be read, which happens
to be 256.

With a blocking read, this would probably be no problem, since we just wait
until we have enough data in the buffer, however with a non-blocking read,
snd_pcm_lib_read(), which gets called by snd_pcm_oss_read3() that's being
called by snd_pcm_oss_read2(), simply returns -EAGAIN since it cannot handle
the much too large request.


Or, as a short summary:
The application is perfectly well aware of how many bytes there are left
to read (from calling SNDCTL_DSP_GETISPACE) and then does a read() with
this amount of bytes, however since the ALSA OSS layer attempts to read
this byte amount in blocks of runtime->oss.period_bytes bytes from the sound
device, we ARTIFICIALLY cause a -EAGAIN to be returned due to insufficient
available data, thus potentially confusing many OSS applications.

Now what to do here?

Thanks!

Andreas Mohr


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
