From: Josh Hattery <hobbz@dodds.net>
Subject: mixer/simple.c bugged? usb-audio
Date: Sun, 18 Aug 2002 21:34:52 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0208182133160.4782-100000@norad.dodds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from norad.dodds.net (postfix@webmail.dodds.net [64.22.192.148])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA13071
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 04:34:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by norad.dodds.net (Postfix) with ESMTP id F400C32495C
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 21:34:52 -0500 (CDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In my previous post I referred to an error message given by xmms (w/
alsa-xmms plugin).  Since then I set up mplayer and when I started to play
a divx file the exact same error came up.  Here's the output of both:

hobbz@graviton:~$ xmms
xmms: simple.c:1376: snd_mixer_selem_get_playback_volume: Assertion
`(unsigned int) channel < s->str[0].channels' failed.
Aborted

hobbz@graviton:~$ gmplayer -vo xv -ao alsa9

MPlayer CVS-020817-00:00-2.95.4 (C) 2000-2002 Arpad Gereoffy (see DOCS!)

CPU: Advanced Micro Devices Athlon 4 PM Palomino/Athlon MP
Multiprocessor/Athlon XP eXtreme Performance (Family: 6, Stepping: 2)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 0
Compiled for x86 CPU with extensions: MMX MMX2 3DNow 3DNowEx SSE

<snip some junk>

Playing /path/to/somedivx.avi
Detected AVI file format!
VIDEO:  [DIV3]  640x360  24bpp  25.00 fps  956.8 kbps (116.8 kbyte/s)
Clip info:
 Software: xxx
 Name: xxx
 Subject: xxx
 Artist: xxx
 Copyright: xxx
 Comments: xxx
Detected audio codec: [a52] afm:14 (AC3-liba52)
Opening audio decoder: [liba52] AC3-liba52
Using SSE optimized IMDCT transform
AC3: 2.0 (dolby)  48000 Hz  192.0 kbit/s
Using MMX optimized resampler
AUDIO: 48000 Hz, 2 ch, sfmt: 0x10 (2 bps), ratio: 24000->192000 (192.0
kbit)
==========================================================================
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
libavcodec: CPU flags: mmx mmxext 3dnow
Detected video codec: [ffdivx] vfm:5 (FFmpeg DivX ;-) (MS MPEG-4 v3))
==========================================================================
gmplayer: simple.c:1376: snd_mixer_selem_get_playback_volume: Assertion
`(unsigned int) channel < s->str[0].channels' failed.

There are two simple.c files under alsa-lib/. The one this refers to is
src/mixer/simple.c.  I've noted line 1376 below.

int snd_mixer_selem_get_playback_volume(snd_mixer_elem_t *elem,
snd_mixer_selem_channel_id_t channel, long *value)
{
        selem_t *s;
        assert(elem);
        assert(elem->type == SND_MIXER_ELEM_SIMPLE);
        s = elem->private_data;
        assert((unsigned int) channel < s->str[PLAY].channels); /* Line 1376 */
        assert(s->caps & (CAP_PVOLUME|CAP_GVOLUME));
        if (s->caps & CAP_PVOLUME_JOIN)
                channel = 0;
        *value = s->str[PLAY].vol[channel];
        return 0;
}

I'm using a Soundblaster Extigy and the snd-usb-audio driver from
alsa-drivers.

I just installed the alsa drivers, libs, and utils on my roommate's
machine with no problem.  The only real difference between our setups is
that he has an SB Live! Platinum.  So I think the error must originate
somewhere in the usb code or the way the data is being returned by the
kernel driver.  Then again, I'm still just a squire when it comes to
coding.

Anyone have any insight?

Regards,

Josh Hattery



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
