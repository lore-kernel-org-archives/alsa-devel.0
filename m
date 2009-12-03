From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Underruns in basic audio playback application
Date: Thu, 3 Dec 2009 11:04:46 -0500
Message-ID: <829197380912030804u672b31c6ybf30e87828b7576b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id DB4E61038B0
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 17:04:46 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e21so630490fga.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2009 08:04:46 -0800 (PST)
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

Hello all,

I am working on a very basic application that reads a capture device
and outputs to a playback device.  It's what you would traditionally
accomplish with something like the following:

arecord -D hw:1,0 -r 48000 -c 2 -f S16_LE | aplay -

However, in this case, since the final result will be part of a TV
watching application, I need to maintain less than 30ms of latency to
preserve lipsync.

The application I ended up with essentially creates two PCM streams
(one for capture, one for playback), sets them up with the same
parameters in terms of rate, format, channels, etc., and then has a
loop of snd_pcm_readi() and snd_pcm_writei() calls.

The application works, except I am getting a considerable amount of
underruns on the playback device.

Given my relative inexperience with alsa-lib, I suspect that I have
misconfigured one of the parameters effecting buffering - buffer size,
buffer time, period size, period time.

Can anyone offer any constructive suggestions or tips on what these
tuning parameters should be set to for a continuous 48000Khz, 2
channel stream of audio?  Also, should the buffering configuration
really be the same for both the capture and playback stream, or do I
need to play some games such that one requires more/less buffering
than the other?

Thanks in advance,

Devin

-- 
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
