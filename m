From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630 improvements, finally multi PCM channel
 support
Date: Thu, 01 Aug 2002 07:29:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D48C722.5040609@cucumelo.org>
References: <3D48607D.5020406@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Again!

It did not take long time before i found "yet another bug" in my code, 
related to the PCM multichannel stuff.
If you are playing various PCM channels and repently got a pure sinus 
signal instead (of whatever you was playing).
No pain, no gain, ...
Anyone that have downloaded my yesterday snapshot better apply this patch:


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




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
