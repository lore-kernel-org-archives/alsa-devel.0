From: Konstantinos Georgantas <k.georgantas@samsung.com>
Subject: Audio usb switch to alternate setting 0
Date: Sun, 19 Jan 2014 14:50:15 +0100
Message-ID: <52DBD817.8050304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 63B20261692
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 14:50:19 +0100 (CET)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MZN00CX9IFTTN50@mailout3.w1.samsung.com> for
 alsa-devel@alsa-project.org; Sun, 19 Jan 2014 13:50:17 +0000 (GMT)
Received: from [192.168.0.103] ([106.111.34.46])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0MZN00FHGIFS6K40@eusync1.samsung.com> for
 alsa-devel@alsa-project.org; Sun, 19 Jan 2014 13:50:16 +0000 (GMT)
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

Hello,
I am trying to control from the client side which Alternate Setting to 
use. Basically I would like to be able to switch from Alternate Setting 
0 to 1 and vice versa so that I am not receiving any set interface 
requests in the meantime. From the audio class 2.0 documentation I 
understand that I should be able to do something like this by using the 
active alternate setting control, and here comes my main problem.

When I generate an interrupt to the interrupt endpoint I should expect a 
GET request which I never see in the host side (hope I am right here).

Here comes the interrupt:
interrupt->bInfo          = 0x00;
interrupt->bAttribute  = 0x01;
interrupt->wValue       = 0x0100;
interrupt->wIndex       = 0x0004;

Could you please tell me if such a functionality is supported and how 
the interrupt should look like?

Thank you,
Konstantinos
