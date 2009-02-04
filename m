From: Mandar Joshi <emailmandar@yahoo.com>
Subject: Creative X-Fi USB 5.1 Driver
Date: Tue, 3 Feb 2009 20:36:15 -0800 (PST)
Message-ID: <531396.7445.qm@web35601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web35601.mail.mud.yahoo.com (web35601.mail.mud.yahoo.com
	[66.163.179.140])
	by alsa0.perex.cz (Postfix) with SMTP id 1846A103875
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 05:36:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I was reading the USB Audio Specs from http://www.usb.org/developers/devclass_docs
The document talks about Effect Unit Descriptors and few other descriptors.There is no mention of such descriptors in the &#39;lsusb -v&#39; output for the USB X-Fi 5.1
Does this mean thet the X-Fi,Crystalizer features of the USB X-Fi are implemented purely in software?
Here is a link to the lsusb output http://mndar.phpnet.us/usbxfi/files/creative.txt

The document &quot;Audio20 final.pdf&quot; also mentions that bDeviceClass, bDeviceSubClass and bDeviceProtocol should have values 0xEF, 0x02, and 0x01 respectively but in the &#39;lsusb -v&#39; output all three values are 0. Any idea why it is so?

Regards
Mandar Joshi
