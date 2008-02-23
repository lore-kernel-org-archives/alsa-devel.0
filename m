From: Matt Whitlock <matt@whitlock.name>
Subject: How to set idle S/PDIF sample rate?
Date: Fri, 22 Feb 2008 22:34:22 -0500
Message-ID: <200802222234.22975.matt@whitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id AAB09245D3
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 04:34:26 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so132266ana.80
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 19:34:25 -0800 (PST)
Content-Disposition: inline
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

When no programs have the sound hardware open, ALSA drives my Intel HDA's S/PDIF output with silence at 48000 Hz.  How would I change this default so that the idle sample rate is 44100 Hz?  The reason I ask is that my stereo receiver misses the first second or so of each song that I play as it switches from 48000 Hz to 44100 Hz.  I understand that by switching the idle sample rate to 44100 Hz, I would have the same problem whenever playing a DVD, but I can much more happily accept the switching delay when starting DVDs than I can when starting music playback.

I've tried everything, including replacing /usr/share/alsa/alsa.conf with a single PCM definition that outputs straight to hardware with "rate 44100", but still, whenever nothing is accessing the sound hardware, ALSA reverts to 48000-Hz silence.  There must be a way to influence that, right?

Alternatively, if ALSA would simply not output anything over S/PDIF when idle, my receiver could just stay at 44100 Hz, albeit unlocked since there would be no data stream at all.  So this is also an acceptable solution to me, but I cannot find any way to make ALSA totally shut up when idle.  It always wants to output silence.  Interestingly, if I mute the IEC958 playback channel and then unmute it, my receiver reports no signal at all until I play a sound, and then after the sound finishes, my receiver reports that it is locked onto PCM at 48000 Hz.  Seems kind of like a bug, doesn't it?

Thanks to anyone who can lend some assistance.
