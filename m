From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/13] bebob: a new driver for
 BridgeCo BeBoB based device
Date: Sun, 01 Dec 2013 13:42:55 +0900
Message-ID: <529ABE4F.6070406@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
 <529A2691.4000401@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 755072608ED
 for <alsa-devel@alsa-project.org>; Sun,  1 Dec 2013 05:43:11 +0100 (CET)
In-Reply-To: <529A2691.4000401@monom.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Wagner <wagi@monom.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Thanks for your testing.

At first, I describe our system to test. I use Ubuntu 13.10. You use 
Fedora 19.

(Dec 01 2013 02:55), Daniel Wagner wrote:
> I have tried this series (incl. the bug fix you recommend) on a FA-66.
> While I see some output in alsa-info, pulseaudio didn't pick it up. I
> also noted that some logs in the dmesg. I am not sure what is supposed
> to work already or not.
>
> Here are my logs
>
> http://www.monom.org/misc/alsa-firewire/2013-11-30

1.pulseaudio
PulseAudio can automatically load 'module-alsa-card' with 
'module-udev-detect' (utilizing sysfs/dbus). But for snd-bebob, this 
mecanism doesn't work because PulseAudio cannot decide profiles for the 
card even if success to detect.

For this problem, I have a need to commit some codes for PulseAudio but 
this may be my future work.

Well, when I test with PulseAudio, I always directly load 
'module-alsa-sink' or 'module-alsa-source' by these lines:
$ pactl load-module module-alsa-sink device=hw:X,X
$ pactl load-module module-alsa-source device=hw:X,X

See in detail:
http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index4h3

2.dmesg
Hm. I want to know which asynchronous transaction is failed.
[  446.796563] snd-bebob fw1.0: transaction failed: no ack
[  446.838567] snd-bebob fw1.0: transaction failed: no ack

Would you investigate which transactions cannot get 'no ack'?


Thank you

Takashi Sakamoto
