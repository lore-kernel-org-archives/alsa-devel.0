From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Thu, 07 Oct 2010 13:35:19 +0200
Message-ID: <4CADB077.3060907@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de>
	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de>	<4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>	<4CAC89EA.8080207@ladisch.de>
	<4CACA471.2000504@showlabor.de>	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 8EC9324480
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 13:35:27 +0200 (CEST)
In-Reply-To: <20101007081010.GZ7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Am 07.10.2010 10:10, schrieb Daniel Mack:
>
> Ah, that makes sense, yes. UAC2 calls this mode "implicit feedback".
> Felix, can you provide a dump of "lsusb -v" for this device?
>
> Daniel
>
>    

A couple of additional notes:

1.
If I force the playback endpoint to async mode  (.ep_attr = 0x05) the 
regular clicks disappear at 48 kHz. But then we are back to completely 
distorted playback at 44.1 kHz.

I guess those of you understanding "implicit feedback" probably expected 
this result.

2.
In Windows switching the clock source from internal to external gives 
these Co packets in usbmon:

ffff88007426a980 49576636 S Co:1:009:0 s 01 0b 0000 0001 0000 0
ffff88007426a980 49577887 C Co:1:009:0 0 0
ffff88007426ab00 49650954 S Co:1:009:0 s 01 0b 0000 0002 0000 0
ffff88007426ab00 49652256 C Co:1:009:0 0 0
ffff88007426a8c0 49789965 S Co:1:009:0 s 01 0b 0001 0001 0000 0
ffff88007426a8c0 49790233 C Co:1:009:0 0 0
ffff88007426a8c0 49808331 S Co:1:009:0 s 01 0b 0002 0002 0000 0 <---- 
here's a difference
ffff88007426a8c0 49808727 C Co:1:009:0 0 0
ffff88007426aa40 49947450 S Co:1:009:0 s 22 01 0100 0001 0003 3 = 80bb00
ffff88007426aa40 49947823 C Co:1:009:0 0 3 >
ffff88007426aa40 49962321 S Co:1:009:0 s 22 01 0100 0081 0003 3 = 80bb00
ffff88007426aa40 49962691 C Co:1:009:0 0 3 >

The device seems to accept an external clock at 48 kHz only.

3.
In Windows switching the clock source from external to internal gives 
these Co packets in usbmon:

ffff88007426aec0 97962867 S Co:1:009:0 s 01 0b 0000 0001 0000 0
ffff88007426aec0 97964056 C Co:1:009:0 0 0
ffff88007426ab00 98031831 S Co:1:009:0 s 01 0b 0000 0002 0000 0
ffff88007426ab00 98033165 C Co:1:009:0 0 0
ffff88007426a980 98093945 S Co:1:009:0 s 01 0b 0001 0001 0000 0
ffff88007426a980 98094160 C Co:1:009:0 0 0
ffff88007426a980 98099994 S Co:1:009:0 s 01 0b 0001 0002 0000 0 <---- 
here's a difference
ffff88007426a980 98101277 C Co:1:009:0 0 0


@Daniel:
You asked for the output of lsusb. Are you thinking of modifying the 
UA-101 driver yourself? Or something more generic? In other words, if 
you already have an idea of a solution I wouldn't have to work myself 
through ua101.c (which I don't understand right now).

@all:
Did anyone notice the patch adding mixer support for the FTU devices I 
send on Sept, 25?

Kind regards,

Felix
