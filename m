From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Thu, 19 Apr 2012 06:26:06 -0400
Message-ID: <4F8FE83E.2070600@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173019pub.verizon.net (vms173019pub.verizon.net
	[206.46.173.19])
	by alsa0.perex.cz (Postfix) with ESMTP id B0CE010B919
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 12:26:22 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173019.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M2Q00FS42BJ61B0@vms173019.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Thu, 19 Apr 2012 05:26:08 -0500 (CDT)
In-reply-to: <4F8FD2A7.60700@ladisch.de>
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

Complete snippet from the log

[  374.104138] usbcore: deregistering interface driver snd-usb-audio
[  374.875660] snd-usb-audio: probe of 1-1:1.1 failed with error -5
[  374.881649] snd-usb-audio: probe of 1-1:1.2 failed with error -5
[  374.887654] snd-usb-audio: probe of 1-1:1.3 failed with error -5
[  374.895366] usbcore: registered new interface driver snd-usb-audio

Sidenote - While I don't have a midi device to test with, it would 
appear that the midi portion registers correctly and is accessible (at 
least through amidi and aplaymidi)

On 04/19/2012 04:53 AM, Clemens Ladisch wrote:
> Chris Cavey wrote:
>>   snd-usb-audio: probe of 1-1:1.1 failed with error -5
>>   snd-usb-audio: probe of 1-1:1.2 failed with error -5
>>   snd-usb-audio: probe of 1-1:1.3 failed with error -5
> Are there no other messages immediately before this?
>
> Daniel, are there places where the code aborts without
> print an error message?
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
