From: Stefano Statuti <stefano.statuti@hotmail.it>
Subject: [BUG]ABit aa8xe sound card not selected
Date: Thu, 15 May 2014 09:38:57 +0200
Message-ID: <DUB127-W341DC0DDBAE2B6BECE8FCE83360@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s35.dub0.hotmail.com (dub0-omc3-s35.dub0.hotmail.com
 [157.55.2.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5BFAC261A7F
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 09:38:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alsa-announce@lists.sourceforge.net" <alsa-announce@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hello,



I have opened this ticket on ubuntu-alsa launchpad  _https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1319291

Raymond (superquad-vortrex2) ask me to contact you.
----quote

    

    

    

  
  Try specify model=6stack-dig

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio-Models.txt
00:1b.0 0403: 8086:2668 (rev 04)

 Subsystem: 147b:1045

send email to alsa-devel mailing list to add pci quirk since Bios does not setup pin default
 Default 0x00000000: [Jack] Line Out at Ext N/A

Sysfs Files

!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:

0x14 0x00000000

0x15 0x00000000

0x16 0x00000000

0x17 0x00000000

0x18 0x00000000

0x19 0x00000000

0x1a 0x00000000

0x1b 0x00000000

0x1c 0x00000000

0x1d 0x00000000

0x1e 0x00000000

0x1f 0x00000000
-----

  
  
  


  
whit Ubuntu 12.04 I don't have this problem

bye
  		 	   		  
