From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: HDSP midi debugged
Date: Fri, 27 Jun 2003 18:52:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306271849500.11149-100000@pnote.perex-int.cz>
References: <3EFC6EB7.1314236D@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EFC6EB7.1314236D@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Jun 2003, Marcus Andersson wrote:

> Hi,
> 
> I have found the reason for the loss of input bytes on the hdsp midi,
> but I don't know how to correctly fix it.
> 
> The function snd_hdsp_midi_input_trigger() is repeatedly called with
> up==true. This results in the input being flushed. Definitely not good.
> 
> Can someone tell me what this function is supposed to do? What does 'up'
> mean? Why is the input flushed here?

The input should be flushed only when the input was not triggered before.
The input is triggered constantly, because there is some polled hardware 
available.

This patch should fix this problem (commited also to CVS):

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.36
diff -u -r1.36 hdsp.c
--- hdsp.c	14 Jun 2003 07:56:02 -0000	1.36
+++ hdsp.c	27 Jun 2003 16:52:32 -0000
@@ -1137,21 +1137,19 @@
 	hdsp_t *hdsp;
 	hdsp_midi_t *hmidi;
 	unsigned long flags;
+	u32 ie;
 
 	hmidi = (hdsp_midi_t *) substream->rmidi->private_data;
 	hdsp = hmidi->hdsp;
+	ie = hmidi->id ? HDSP_Midi1InterruptEnable : HDSP_Midi0InterruptEnable;
 	spin_lock_irqsave (&hdsp->lock, flags);
 	if (up) {
-		snd_hdsp_flush_midi_input (hdsp, hmidi->id);
-		if (hmidi->id) 
-			hdsp->control_register |= HDSP_Midi1InterruptEnable;
-		else 
-			hdsp->control_register |= HDSP_Midi0InterruptEnable;
+		if (!(hdsp->control_register & ie)) {
+			snd_hdsp_flush_midi_input (hdsp, hmidi->id);
+			hdsp->control_register |= ie;
+		}
 	} else {
-		if (hmidi->id) 
-			hdsp->control_register &= ~HDSP_Midi1InterruptEnable;
-		else 
-			hdsp->control_register &= ~HDSP_Midi0InterruptEnable;
+		hdsp->control_register &= ~ie;
 	}
 
 	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
