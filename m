From: FirebUntU <info@firebuntu.com>
Subject: Trouble about Roland UA-11 UA-33 UA-55 and
	snd-usb-audio module
Date: Wed, 14 Nov 2012 08:35:01 +0100
Message-ID: <50A349A5.6010403@firebuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EBA5260376
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 08:35:05 +0100 (CET)
Received: from [62.19.188.233] (port=56563 helo=[192.168.1.4])
 by n23.mail01.mtsvc.net with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
 (Exim 4.72) (envelope-from <info@firebuntu.com>) id 1TYXV1-0007Ug-V2
 for alsa-devel@alsa-project.org; Wed, 14 Nov 2012 02:35:04 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi guys,

I write you about support of snd-usb-audio module and a relatively-new 
gamma of devices from Roland/Edirol:

DUO CAPTURE, TRI CAPTURE and QUAD CAPTURE

respectively:

UA-11, UA-33, UA-55

These aren't not listed in the Alsa db.
I have searched a solution for a week and I haven't found a trick to 
make UA-11 to work under Alsa 1.25.0
then I downloaded the driver for try to patch it and I found these 
devices is not listed in the tricks table

In despair I have played with the switch button called "EXT * **" in the 
bottom of the unit of UA-11 and magically the device ID is transformed 
from * 0582:012b to ** 0582:0137

Image: https://dl.dropbox.com/u/32759898/output.jpg
(Rear of the UA-11 unit, from the manual)


*Before* (Recognized from udev - Unknown from alsa):
http://www.alsa-project.org/db/?f=502ee68cf31882ba9ef23525fd66452c34d329e1

*After* (Recognized from udev - Recognized from alsa):
http://www.alsa-project.org/db/?f=b2ae3e4331fb3fe613ba71e7aba1ad2e0e6dcd29

In the tricks table header of ALSA the 0582:0137 stay for PM-1000 in 
/TODO/ statement.
I understand the EXT switch, undiscovered in the manual of the DUO 
CAPTURE is - as the fact - the Advanced Mode.

Now the peripherical running both in playback and recording in 16 and 24 
bit and without any mixer options in alsamixer.


Can you update future releases with this gamma of devices?


Awaiting for your positive response :)

Thanks.


Best regards,

Leonardo
