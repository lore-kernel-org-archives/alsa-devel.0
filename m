From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630, secondary CODEC output.
Date: Thu, 01 Aug 2002 14:57:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D493047.6060009@cucumelo.org>
References: <3D41D4DC.60004@cucumelo.org>	<s5h1y9ic3xs.wl@alsa2.suse.de>	<3D4901D9.7040409@cucumelo.org>	<s5hwuraalt8.wl@alsa2.suse.de> <s5hptx2agxp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA06735
	for <alsa-devel@alsa-project.org>; Thu, 1 Aug 2002 15:47:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
>
>
>about the secondary codec on terratec xfire: it's still not detected.
>could you test the latest cvs driver?  i'm afraid that i did something
>wrong in merging...
>
My quick look on the cvsweb everything looks just fine, just one small 
critical
fix that I missed in my 0731 release, I believe that's easy commited to 
CVS (see my notice about this
earlier today) in _dsp_unlink_scb() function:

--- 
/home/pub/src/alsa-driver-0.9.0rc2-bs20020731/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c     
Wed Jul 31 23:19:19 2002
+++ dsp_spos_scb_lib.c  Thu Aug  1 07:25:14 2002
@@ -148,6 +148,12 @@
       spin_lock_irqsave(&chip->reg_lock, flags);    
    /* update entry in DSP RAM */
    snd_cs46xx_poke(chip,
+                    (scb->address + SCBsubListPtr) << 2,
+                    (scb->sub_list_ptr->address << 0x10) |
+                    (scb->next_scb_ptr->address));
+
+    /* update parent entry in DSP RAM */
+    snd_cs46xx_poke(chip,
                    (scb->parent_scb_ptr->address + SCBsubListPtr) << 2,
                    (scb->parent_scb_ptr->sub_list_ptr->address << 0x10) |
                    (scb->parent_scb_ptr->next_scb_ptr->address));

As soon I can I will test the CVS release, I'll comeback with feedback. 
Any change from now
will be  based on the CVS.
About the secondary CODEC, 1.03 codecs are not supported with the 
current code, read, and write fucntions
needs to be slightly different for 1.03 codecs. I believe there are very 
few cards shipped with 1.03 codecs, dont know the case
with terratec.
All differents boards always are shipped with some dam GPIO controls 
which you never knows where they are wired, which never are documented, 
if the terratec board is shipped with 2.0 codecs and it's not detected I 
believe it's some magic GPIO pin that we need
to turn on.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
