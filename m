From: Detlef Urban <onkel@paraair.de>
Subject: Alsa driver for Tascam US-16x08
Date: Mon, 4 Jul 2016 19:25:08 +0200
Message-ID: <577A9BF4.90304@paraair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5A5265AB9
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 19:25:13 +0200 (CEST)
Received: from [192.168.178.38] ([93.130.114.84]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0MeSdD-1awnAe1uZD-00QBSq for
 <alsa-devel@alsa-project.org>; Mon, 04 Jul 2016 19:25:11 +0200
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

Hi,

I'm a former application developer at a big IT company.

Most of my private time I spend with semi-professional studio recording 
using Ubuntu Studio (Ardour).
I bought a nice external sound device from Tascam called US-16x08 and it 
works very well.
This device also contains some signal processing capabilities like a 
compressor and a parametric equalizer. But unfortunately there was no 
Linux driver available from the manufacturer and so I cant use there 
functionalities.
So I started with a nightmare of re-engineering by monitoring USB 
communication via usbmon and wireshark.

Now after 3-4 weeks I'm able to completely control this device with a 
customized snd-usb-audio kernel module.
Additionally I developed a tiny GUI mixer application to test my driver.
But I'm not very familiar with non-coding aspects of driver deployment 
(documentation, deployment etc.).

Can some please help me with some hints/links, so that other users can 
benefit of my work?

regards
Detlef
