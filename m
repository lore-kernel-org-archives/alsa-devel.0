From: Zinx Verituse <zinx@epicsol.org>
Subject: CMI9739A
Date: Wed, 24 Nov 2004 18:46:49 -0600
Message-ID: <20041125004649.GA21551@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from imf17aec.mail.bellsouth.net (imf17aec.mail.bellsouth.net [205.152.59.65])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2D6B52A2
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 01:46:45 +0100 (MET)
Received: from bliss.chaos ([68.17.128.52]) by imf17aec.mail.bellsouth.net
          (InterMail vM.5.01.06.11 201-253-122-130-111-20040605) with ESMTP
          id <20041125004640.BPDQ1994.imf17aec.mail.bellsouth.net@bliss.chaos>
          for <alsa-devel@alsa-project.org>;
          Wed, 24 Nov 2004 19:46:40 -0500
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently purchased a motherboard with an on-board CMI9739A (or so it claims)

the id is: 0x434d4983

Unfortunately, simply adding the line:

{ 0x434d4983, 0xffffffff, "CMI9739A",           patch_cm9739,   NULL },

causes the card to be muted, reguardless of the mixer, because of the init
code in patch_cm9739 -- the init code apparently isn't compatible.

Removing the initialization code, but leaving the ops, gives a few more
functional mixer options (like "Line-In as Surround" and "Mic as Center/LFE")

-- 
Zinx Verituse                                    http://zinx.xmms.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
