From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH/RFC] emu10k1 multichannel PCM
Date: Wed, 17 Nov 2004 17:48:36 -0500
Message-ID: <1100731717.1428.14.camel@krustophenia.net>
References: <1100300857.19038.14.camel@krustophenia.net>
	 <1100405924.16103.23.camel@krustophenia.net>
	 <1100672577.5832.7.camel@krustophenia.net>  <s5his84si8l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aWAo38q/v/JvJvNpML0N"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his84si8l.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-aWAo38q/v/JvJvNpML0N
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-11-17 at 14:44 +0100, Takashi Iwai wrote:
> The code looks alsmot fine.  Please keep the 8-letter tab stop for
> indentation

I noticed while cleaning my code that emumixer.c is a little whitespace
damaged.  Here is a small patch to clean it up.  This patch only changes
whitespace.  The changes should not be controversial, the style is
preserved.  I send this so that I do not perpetuate it by copy and paste
coding.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee

--=-aWAo38q/v/JvJvNpML0N
Content-Disposition: attachment; filename=emumixer-whitespace-cleanup.patch
Content-Type: text/x-patch; name=emumixer-whitespace-cleanup.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-trivial/alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.26
diff -u -r1.26 emumixer.c
--- alsa-trivial/alsa-kernel/pci/emu10k1/emumixer.c	17 Aug 2004 10:16:03 -0000	1.26
+++ alsa-trivial/alsa-kernel/pci/emu10k1/emumixer.c	17 Nov 2004 22:43:49 -0000
@@ -54,7 +54,7 @@
 	ucontrol->value.iec958.status[2] = (emu->spdif_bits[idx] >> 16) & 0xff;
 	ucontrol->value.iec958.status[3] = (emu->spdif_bits[idx] >> 24) & 0xff;
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_spdif_get_mask(snd_kcontrol_t * kcontrol,
@@ -64,7 +64,7 @@
 	ucontrol->value.iec958.status[1] = 0xff;
 	ucontrol->value.iec958.status[2] = 0xff;
 	ucontrol->value.iec958.status[3] = 0xff;
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_spdif_put(snd_kcontrol_t * kcontrol,
@@ -87,27 +87,27 @@
 		emu->spdif_bits[idx] = val;
 	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1_spdif_mask_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
-        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
 	.count =	4,
-        .info =         snd_emu10k1_spdif_info,
-        .get =          snd_emu10k1_spdif_get_mask
+	.info =         snd_emu10k1_spdif_info,
+	.get =          snd_emu10k1_spdif_get_mask
 };
 
 static snd_kcontrol_new_t snd_emu10k1_spdif_control =
 {
-        .iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
 	.count =	4,
-        .info =         snd_emu10k1_spdif_info,
-        .get =          snd_emu10k1_spdif_get,
-        .put =          snd_emu10k1_spdif_put
+	.info =         snd_emu10k1_spdif_info,
+	.get =          snd_emu10k1_spdif_get,
+	.put =          snd_emu10k1_spdif_put
 };
 
 
@@ -165,7 +165,7 @@
 			ucontrol->value.integer.value[(voice * num_efx) + idx] = 
 				mix->send_routing[voice][idx] & mask;
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_send_routing_put(snd_kcontrol_t * kcontrol,
@@ -199,18 +199,18 @@
 		}
 	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1_send_routing_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
-        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "EMU10K1 PCM Send Routing",
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "EMU10K1 PCM Send Routing",
 	.count =	32,
-        .info =         snd_emu10k1_send_routing_info,
-        .get =          snd_emu10k1_send_routing_get,
-        .put =          snd_emu10k1_send_routing_put
+	.info =         snd_emu10k1_send_routing_info,
+	.get =          snd_emu10k1_send_routing_get,
+	.put =          snd_emu10k1_send_routing_put
 };
 
 static int snd_emu10k1_send_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
@@ -236,7 +236,7 @@
 	for (idx = 0; idx < 3*num_efx; idx++)
 		ucontrol->value.integer.value[idx] = mix->send_volume[idx/num_efx][idx%num_efx];
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_send_volume_put(snd_kcontrol_t * kcontrol,
@@ -268,18 +268,18 @@
 		}
 	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1_send_volume_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
-        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "EMU10K1 PCM Send Volume",
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "EMU10K1 PCM Send Volume",
 	.count =	32,
-        .info =         snd_emu10k1_send_volume_info,
-        .get =          snd_emu10k1_send_volume_get,
-        .put =          snd_emu10k1_send_volume_put
+	.info =         snd_emu10k1_send_volume_info,
+	.get =          snd_emu10k1_send_volume_get,
+	.put =          snd_emu10k1_send_volume_put
 };
 
 static int snd_emu10k1_attn_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
@@ -303,7 +303,7 @@
 	for (idx = 0; idx < 3; idx++)
 		ucontrol->value.integer.value[idx] = mix->attn[idx];
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_attn_put(snd_kcontrol_t * kcontrol,
@@ -331,18 +331,18 @@
 		}
 	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1_attn_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
-        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "EMU10K1 PCM Volume",
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "EMU10K1 PCM Volume",
 	.count =	32,
-        .info =         snd_emu10k1_attn_info,
-        .get =          snd_emu10k1_attn_get,
-        .put =          snd_emu10k1_attn_put
+	.info =         snd_emu10k1_attn_info,
+	.get =          snd_emu10k1_attn_get,
+	.put =          snd_emu10k1_attn_put
 };
 
 static int snd_emu10k1_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
@@ -363,7 +363,7 @@
 		ucontrol->value.integer.value[0] = inl(emu->port + A_IOCFG) & A_IOCFG_GPOUT0 ? 1 : 0;
 	else
 		ucontrol->value.integer.value[0] = inl(emu->port + HCFG) & HCFG_GPOUT0 ? 1 : 0;
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1_shared_spdif_put(snd_kcontrol_t * kcontrol,
@@ -394,7 +394,7 @@
 		outl(reg | val, emu->port + HCFG);
 	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1_shared_spdif __devinitdata =

--=-aWAo38q/v/JvJvNpML0N--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
