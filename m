From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: snd-azt3328 bug.
Date: Mon, 25 Nov 2002 11:40:38 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE18DA6.3050503@boosthardware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000909080605060505030706"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, lzshun@163.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000909080605060505030706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have forwarded this on to hte alsa-devel list as this is a bug. Please 
sign up to the alsa-devel mailing list to help get this driver working 
correctly.

----
i do it by 
http://alsa-project.org/alsa-doc/doc-php/template.php3?company=AzTech&amp;card=PCI+168&amp;chip=AZF3328&amp;module=azt3328
why i use  alsa-0.9.0rc6   driver   and
   when run to

[root@localhost root]# modprobe snd-azt3328
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: unresolved symbol 
snd_mpu401_uart_interrupt_R4ea4dc60
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: unresolved symbol 
snd_mpu401_uart_new_R0588a8ba
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: insmod 
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o failed
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: insmod 
snd-azt3328 failed
----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman

--------------000909080605060505030706
Content-Type: message/rfc822;
 name="ALSA: doc notes additions"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ALSA: doc notes additions"

Return-Path: <wwwrun@alsa.alsa-project.org>
Delivered-To: boosth-pshirkey@boosthardware.com
Received: (qmail 20210 invoked from network); 25 Nov 2002 00:03:57 -0000
Received: from alsa.jcu.cz (HELO alsa.alsa-project.org) (160.217.1.49)
  by -H with SMTP; 25 Nov 2002 00:03:57 -0000
Received: (from wwwrun@localhost)
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id BAA30193;
	Mon, 25 Nov 2002 01:04:52 +0100
Date: Mon, 25 Nov 2002 01:04:52 +0100
Message-Id: <200211250004.BAA30193@alsa.alsa-project.org>
To: pshirkey@boosthardware.com
Subject: ALSA: doc notes additions
From: lzshun@163.com

The following has been submitted as a note for the documentation of azt3328. Save this as /alsa-doc/additions/azt3328.php3. If there is not a file already you may need to use the template. Don't forget to add any new pages to cvs.

 cvs add www/alsa-doc/additions/azt3328.php3


	</td></tr>
	<tr><td align="center">

<!-- Use the above if there are multiple entries in a file -->
		<table border="0" cellpadding="4" cellspacing="0" width="620">
		<tr valign="top">
		<td bgcolor="#bed1be" colspan="2">
    	        <table border="0" cellpadding="2" cellspacing="0" width="620">
    	        <tr valign="top"><td>
       	       	lzshun   &nbsp &nbsp <a href="mailto: lzshun@163.com">lzshun@163.com</a><br>
       	       	Monday, 25 November 2002</td>
    	        <td align="right">
    	        <br></td>
    	        </tr>
    	       	<tr bgcolor="#f0f0f0"><td colspan="2">
    	        <pre>
  Patrick Shirkey

    i do it by http://alsa-project.org/alsa-doc/doc-php/template.php3?company=AzTech&amp;card=PCI+168&amp;chip=AZF3328&amp;module=azt3328
why i use  alsa-0.9.0rc6   driver   and
  when run to
[root@localhost root]# modprobe snd-azt3328
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: unresolved symbol snd_mpu401_uart_interrupt_R4ea4dc60
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: unresolved symbol snd_mpu401_uart_new_R0588a8ba
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: insmod /lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o failed
/lib/modules/2.4.18-14/kernel/sound/pci/snd-azt3328.o: insmod snd-azt3328 failed

&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;lzshun@163.com
&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;&amp;#12288;2002-11-23

                  please tell me how can i use my soundcard work  under linux 
 THANKS

&amp;#27492;
		        </pre>
    	        </td></tr>
    	        </table>
		</td>
		</tr>
		</table>




--------------000909080605060505030706--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
