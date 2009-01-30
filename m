From: Mandar Joshi <emailmandar@yahoo.com>
Subject: Creative X-Fi USB 5.1 Driver
Date: Thu, 29 Jan 2009 21:30:28 -0800 (PST)
Message-ID: <673583.88732.qm@web35608.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web35608.mail.mud.yahoo.com (web35608.mail.mud.yahoo.com
	[66.163.179.147]) by alsa0.perex.cz (Postfix) with SMTP id 3C30D243DD
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 06:30:30 +0100 (CET)
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
   I walked through the code for snd-usb-audio and have a fair idea about the structure of the driver. I also
went through the &quot;writing-an-alsa-driver&quot; article on http://www.alsa-project.org
   Here is the stuff I&#39;ve done so far http://mndar.phpnet.us/usbxfi/ .The link contains the &quot;lsusb -v&quot; output for the Creative USB X-Fi 5.1 . 
The xfi-0.0.0.0.tar.bz2 has the basic structure of an alsa driver (copied from the caiaq usb driver). It presently just loads the module when the card is connected.
Output in /var/log/messages
-------------------------------------------
Jan 30 10:46:29 mandar Found Creative USB X-Fi 5.1!!
Jan 30 10:46:29 mandar 0 041e:3042
Jan 30 10:46:29 mandar Found Creative USB X-Fi 5.1!!
Jan 30 10:46:29 mandar 0 041e:3042
Jan 30 10:46:29 mandar Found Creative USB X-Fi 5.1!!
Jan 30 10:46:29 mandar 0 041e:3042
Jan 30 10:46:29 mandar usbcore: registered new interface driver snd-usb-xfi
--------------------------------------------------------------------------------
As you can see, the probe is being called 3 times. Can someone please go through the source and let me know if I&#39;m headed in the right direction?
I&#39;m a newbie to alsa driver development and would really appreciate any input from you guys.
Also, please have a look the creative.txt file in the link. Its the &#39;lsusb -v&#39; output for the card. How exactly do I interpret and use this information?

Regards
Mandar Joshi
