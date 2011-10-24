From: Nikolay Nikolov <nickysn@gmail.com>
Subject: ALSA PulseAudio plugin: snd_pcm_rewindable() returns
 >0, but snd_pcm_rewind() is broken
Date: Mon, 24 Oct 2011 16:28:10 +0300
Message-ID: <4EA567EA.1020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 14222103834
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 15:28:15 +0200 (CEST)
Received: by gyg8 with SMTP id 8so6081540gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 06:28:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I submitted a bug report for this here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5464
I got a comment, which said I should post this on the mailing list, so 
I'm doing this now:

I'm writing a program that tries to use the snd_pcm_rewind() function if 
it's available and I'm having serious trouble with the alsa-pulseaudio 
plugin.

I'm using the max buffer size, which is 1048576 frames (4MB buffer, 
16-bit stereo). The buffer is almost full when I try to rewind. I first 
call snd_pcm_rewindable() and it returns a greater than zero value. Then 
I call snd_pcm_rewind() with this value and it returns success, i.e. a 
positive value of frames actually rewound. I then call snd_pcm_writei 
with the number of frames rewound and I get a weird pause (several 
seconds) in the audio on the next poll. Audio then continues from the 
middle; the beginning of the audio that was rewritten immediately after 
rewind() has been dropped. Also, pulseaudio reports several times the 
following error:

protocol-native.c: Failed to push data into queue

After looking at the alsa-lib and alsa-plugins sources, it seems that 
snd_pcm_rewind() for ioplug devices only updates an internal pointer and 
doesn't notify pulseaudio, so on the next write we just try to push too 
much data to the pulseaudio stream. After googling a bit, I found this 
email from 17 Feb 2010 from Lennart Poettering, which says that 
snd_pcm_rewind() is broken for the alsa-pulseaudio plugin.

http://ns.spinics.net/lists/alsa-devel/msg31536.html


Also, this mail:

http://lists.freedesktop.org/archives/pulseaudio-bugs/2010-July/004051.html

says that snd_pcm_rewindable() should always return 0 frames on ioplug 
devices, and if that's not the case, then it's a bug in alsa.

So, if I'm getting this right, either snd_pcm_rewindable() should be 
fixed to return 0, or snd_pcm_rewind() should be fixed to work properly 
with the alsa-pulseaudio plugin.

Thanks,
Nikolay
