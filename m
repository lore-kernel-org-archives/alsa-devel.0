From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Thu, 08 Jul 2010 08:33:34 +0200
Message-ID: <4C35713E.1090709@ladisch.de>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 325ED24638
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 08:33:40 +0200 (CEST)
In-Reply-To: <op.vff0au0jy9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viliam Kubis <viliam.kubis@gmail.com>, Lydia Wang <lydiawang@viatech.com.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Viliam Kubis wrote:
> Hello, for quite some time the "Smart 5.1" function in alsa is not working
> properly when motherboard has only 3 audio jacks.
> 
> speaker-test -c 4 -t wav -Dsurround40
> 
> Channels count (4) not available for playbacks: Invalid argument

Please try the patch below.

(This function uses 0x12 and 0x13 as the NIDs for the center/LFE and
side DACs.  Shouldn't these be 0x24 and 0x25, as per the datasheet?)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -2265,6 +2265,13 @@ static int vt1708_auto_fill_dac_nids(str
 		}
 	}
 
+	/* for Smart 5.1, line/mic inputs double as output pins */
+	if (cfg->line_outs == 1) {
+		spec->multiout.num_dacs = 3;
+		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
+		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x12;
+	}
+
 	return 0;
 }
