From: Artem Makhutov <artem@makhutov.org>
Subject: Re: Huawei K3715 UMTS stick and alsa
Date: Fri, 31 Jul 2009 00:38:37 +0200
Message-ID: <4A7220ED.6050406@makhutov.org>
References: <20090726224300.GA26953@titan.makhutov-it.de>	<4A6EAA7E.4090207@ladisch.de>
	<20090729093331.GB26953@titan.makhutov-it.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bane.moelleritberatung.de (bane.moelleritberatung.de
	[77.37.2.25]) by alsa0.perex.cz (Postfix) with ESMTP id 22EBF24470
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 00:38:41 +0200 (CEST)
In-Reply-To: <20090729093331.GB26953@titan.makhutov-it.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Artem Makhutov schrieb:
> [...]
> I have done some small test with some AT commands using Windows and was trying
> to get audio to COM16 without the "Mobile Partner" software. But it did not
> worked.
> 
>>> The payload of this interfaces is 320 bytes.
>> How many bytes per second?

The phone is sending 320 bytes every 20ms. So one second of call is 
16000 bytes.

I finally managed to write the captured payload data to a file.
I can playback the audio now using

aplay -r 8000 -c 1 -f S16_LE test.wav

If you send the AT-Command "AT^CVOICE?" to the card then it will answer 
with "^CVOICE:0,8000,16,20" it is also possible to change this setting. 
So I think that the card should be able to output other audio formats 
too (like 3G wideband audio), but I have not tested this command out.

The next thing to do is to find out how to make the UMTS-Card output 
sound without using the "Mobile Partner" application.

Regards, Artem
