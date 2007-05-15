From: ramkromberg@mail.com
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Tue, 15 May 2007 10:50:16 +0200
Message-ID: <20070515085016.C02081BF258@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 438EB24803
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 10:50:19 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	080E11800128
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 08:50:17 +0000 (GMT)
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
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You did it Rene !!!
>sudo ./eeprom
>sudo modprobe snd-sgalaxy sbport=0x220 wssport=0x530

It's working now !!
I downloaded the binary (i didn't compile the code), chmod it, sudo it
and the sgalaxy worked !!!
the sb8 didn't work but I don't really care for that anyhow :-)

For the record, I tested it on xubuntu 7.04 with xmms.

Are you now planning to implement the code to the driver itself ?
If you want me to test anything, let me know.

i'm also considering installing slackware 11 since I need the
preformance...

THANKS !!!
Ram Kromberg
ramkromberg@mail.com
