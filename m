Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8975C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 10:21:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F83923AA1
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 10:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F83923AA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B77516E6;
	Tue,  8 Dec 2020 11:20:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B77516E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607422893;
	bh=C8013QHlDL3TNLjqJPy2p5kRfNaqisHP910bxiPKjok=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pRnoe2WWIn+BKu9R+jZY5fFkmUr0eQo+xPmHauztMgNn7oQ+eaJPuAllmU/q2hIBg
	 V3tV21NCClTKnkw4JNBVEg41ZSB5m8SClgDpaToAz3TiQu7KQfP23/+Jnt7d7T7YBw
	 SbbdWnQvYhfN0JRwMs6JOnOTmjL5tbKx0m21gQEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2EC4F80269;
	Tue,  8 Dec 2020 11:19:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AF00F8019D; Tue,  8 Dec 2020 11:15:17 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A6D7F80130
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 11:15:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A6D7F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de
 header.b="b87i2/tU"
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 9D0E32400FB
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 11:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1607422508; bh=C8013QHlDL3TNLjqJPy2p5kRfNaqisHP910bxiPKjok=;
 h=Date:From:To:Subject:From;
 b=b87i2/tU2IZ7swGVA3xcEOqKuitDaw4LuJBDbRFufS6RpiehF47G4uQHvSMkkrPag
 gy1F3/D6+W962Nq18uwYBqJJm1f6Oh7+tdYuZ40sOBPfYMrvYKzblTU6zflx7o8aX1
 lt2vgODO6gkt/igQzCUrNZwcU6tfww9FRxEqsRh47Gytk/oeqElMm2H+kCX/PJQ2SV
 yXy5QfhXVdZgfPL1awabb8IOYECgkOxKyw1h0VzVHwmsAtPEHxA2SmcTCY3JR5Lud+
 4wUkWJe9K34tzipLY39qbOzi7wL2SLdxDaF/m5nciwPWabXWoxQv7ZGvcvFbFvJ7U1
 F32L+iPewFU7Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4CqwzJ1X0Nz9rxK
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 11:15:08 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Dec 2020 11:15:08 +0100
From: meschi@posteo.de
To: alsa-devel@alsa-project.org
Subject: Steinberg UR22 Crackling and Clicks
Message-ID: <ce03244f4699ffc9574ecc2dae41a417@posteo.de>
X-Sender: meschi@posteo.de
User-Agent: Posteo Webmail
X-Mailman-Approved-At: Tue, 08 Dec 2020 11:19:44 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

I am using a Steinberg UR22 audio interface. Since installing Ubuntu 
20.04 on my workstation I have slight crackling in audio playback. It 
doesn't matter if the audio gets routed through pulse, jack or played 
straight to alsa. When running jack, the crackling is not showing any 
xruns. It's not possible to get any glitch-free playback in the system. 
The onboard intel audio works fine.

My system:

alsa info: 
alsa-project.org/db/?f=8b821b17a8c83fa5db866f34a5b4dfe74d640a32

Processor: Intel Xeon X5687

$ uname -a

Linux WorkStation-T5500 5.4.0-56-lowlatency #62-Ubuntu SMP PREEMPT Mon 
Nov 23 20:19:44 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux



I have tried:

5.4.0-56-generic and -lowlatency

5.8.0-31-generic and -lowlatency

setting cpu governor to performance

using nouveau driver over nvidia



When playing a file with aplay like this:

systemctl --user stop pulseaudio.socket
systemctl --user stop pulseaudio.service
aplay -D plughw:CARD=UR22 ./test.wav



slight crackling can be heard every 5-10 seconds. It also appears, that 
the clicks heard are not always on both channels, sometimes the left 
stereo channel clicks, sometimes the right, sometimes both.



Plugging the Interface into different USB-ports doesn't help. The only 
external devices connected via USB are my mouse and my keyboard. On 
Wndows the same setup on the same machine works fine.

To make things even weirder, using the same audio interface on my 
Thinkpad x220 (Core i5-2540M) with ubuntu 20.04 and 5.4.0.56-lowlatency 
does not show this problem.



Running dmesg seems to show nothing audio driver related after:

[ 22.425520] usbcore: registered new interface driver snd-usb-audio



I have found a similar issue showcasing the problem on manjaro with a 
differend soundcard. Therefore I suspect the problem is caused by ALSA 
interacting with the hardware.

https://forum.manjaro.org/t/pops-clicks-on-audio-interface/40129



Here is another occurence on ubuntu on yet another audio interface.

https://askubuntu.com/questions/1256787/ubuntu-2004-novation-xiosynth-external-usb-audio-interface-producing-popping



If I can supply more information I'm happy to help. I couldn't find a 
similar issue in this mailing list, so if this is already fixed I 
apologize in advance.



Kilian


