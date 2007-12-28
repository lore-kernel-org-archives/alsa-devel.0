From: "Jerone Young" <jerone@gmail.com>
Subject: [PATCH] [ALSA-KERNEL] Add IEC958 digital out support
	to AD1984 for Lenovo Thinkpads T61/X61
Date: Thu, 27 Dec 2007 21:22:55 -0600
Message-ID: <9f50a7a00712271922v3ef285a9pc390abd6b03b081f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14848_24107758.1198812175369"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 92EE2244C6
	for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2007 04:22:56 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so1856382fgb.44
	for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2007 19:22:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_14848_24107758.1198812175369
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds IEC958 digital out support for the AD1984 sound card.
This card can be found in Lenovo Thinkapds T61/X61. The digital out is
not located on the Thinkpad, but optional docking station (it's coxial
digital out). I've add this support as it is done the exact same way
for the AD1983 & AD1884.

I have tested this patch with my Lenovo Thinkpad T61 hooked up to a
docking station (that has the digital coxial) and then run to my home
theater reciever. Works like a charm :-)

Patch is attached and also in this email.

Signed-off-by: Jerone Young <jerone@gmail.com>


diff -r 1227a1c12325 pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Mon Dec 24 14:40:56 2007 +0100
+++ b/pci/hda/patch_analog.c	Thu Dec 27 17:41:13 2007 -0600
@@ -3095,6 +3095,16 @@ static struct snd_kcontrol_new ad1984_th
 		.get = ad198x_mux_enum_get,
 		.put = ad198x_mux_enum_put,
 	},
+	/* SPDIF controls */
+	HDA_CODEC_VOLUME("IEC958 Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
+		/* identical with ad1983 */
+		.info = ad1983_spdif_route_info,
+		.get = ad1983_spdif_route_get,
+		.put = ad1983_spdif_route_put,
+	},
 	{ } /* end */
 };

@@ -3197,7 +3207,7 @@ static int patch_ad1984(struct hda_codec
 		codec->patch_ops.build_pcms = ad1984_build_pcms;
 		break;
 	case AD1984_THINKPAD:
-		spec->multiout.dig_out_nid = 0;
+		spec->multiout.dig_out_nid = AD1884_SPDIF_OUT;
 		spec->input_mux = &ad1984_thinkpad_capture_source;
 		spec->mixers[0] = ad1984_thinkpad_mixers;
 		spec->init_verbs[spec->num_init_verbs++] = ad1984_thinkpad_init_verbs;

------=_Part_14848_24107758.1198812175369
Content-Type: application/octet-stream; name=add_ad1984_spdif
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faq5qtox0
Content-Disposition: attachment; filename=add_ad1984_spdif

VGhpcyBwYXRjaCBhZGRzIElFQzk1OCBkaWdpdGFsIG91dCBzdXBwb3J0IGZvciB0aGUgQUQxOTg0
IHNvdW5kIGNhcmQuIFRoaXMgY2FyZCBjYW4gYmUgZm91bmQgaW4gTGVub3ZvIFRoaW5rYXBkcyBU
NjEvWDYxLiBUaGUgZGlnaXRhbCBvdXQgaXMgbm90IGxvY2F0ZWQgb24gdGhlIFRoaW5rcGFkLCBi
dXQgb3B0aW9uYWwgZG9ja2luZyBzdGF0aW9uIChpdCdzIGNveGlhbCBkaWdpdGFsIG91dCkuIEkn
dmUgYWRkIHRoaXMgc3VwcG9ydCBhcyBpdCBpcyBkb25lIHRoZSBleGFjdCBzYW1lIHdheSBmb3Ig
dGhlIEFEMTk4MyAmIEFEMTg4NC4KCmRpZmYgLXIgMTIyN2ExYzEyMzI1IHBjaS9oZGEvcGF0Y2hf
YW5hbG9nLmMKLS0tIGEvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYwlNb24gRGVjIDI0IDE0OjQwOjU2
IDIwMDcgKzAxMDAKKysrIGIvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYwlUaHUgRGVjIDI3IDE3OjQx
OjEzIDIwMDcgLTA2MDAKQEAgLTMwOTUsNiArMzA5NSwxNiBAQCBzdGF0aWMgc3RydWN0IHNuZF9r
Y29udHJvbF9uZXcgYWQxOTg0X3RoCiAJCS5nZXQgPSBhZDE5OHhfbXV4X2VudW1fZ2V0LAogCQku
cHV0ID0gYWQxOTh4X211eF9lbnVtX3B1dCwKIAl9LAorCS8qIFNQRElGIGNvbnRyb2xzICovCisJ
SERBX0NPREVDX1ZPTFVNRSgiSUVDOTU4IFBsYXliYWNrIFZvbHVtZSIsIDB4MWIsIDB4MCwgSERB
X09VVFBVVCksCisJeworCQkuaWZhY2UgPSBTTkRSVl9DVExfRUxFTV9JRkFDRV9NSVhFUiwKKwkJ
Lm5hbWUgPSBTTkRSVl9DVExfTkFNRV9JRUM5NTgoIiIsUExBWUJBQ0ssTk9ORSkgIlNvdXJjZSIs
CisJCS8qIGlkZW50aWNhbCB3aXRoIGFkMTk4MyAqLworCQkuaW5mbyA9IGFkMTk4M19zcGRpZl9y
b3V0ZV9pbmZvLAorCQkuZ2V0ID0gYWQxOTgzX3NwZGlmX3JvdXRlX2dldCwKKwkJLnB1dCA9IGFk
MTk4M19zcGRpZl9yb3V0ZV9wdXQsCisJfSwKIAl7IH0gLyogZW5kICovCiB9OwogCkBAIC0zMTk3
LDcgKzMyMDcsNyBAQCBzdGF0aWMgaW50IHBhdGNoX2FkMTk4NChzdHJ1Y3QgaGRhX2NvZGVjCiAJ
CWNvZGVjLT5wYXRjaF9vcHMuYnVpbGRfcGNtcyA9IGFkMTk4NF9idWlsZF9wY21zOwogCQlicmVh
azsKIAljYXNlIEFEMTk4NF9USElOS1BBRDoKLQkJc3BlYy0+bXVsdGlvdXQuZGlnX291dF9uaWQg
PSAwOworCQlzcGVjLT5tdWx0aW91dC5kaWdfb3V0X25pZCA9IEFEMTg4NF9TUERJRl9PVVQ7CiAJ
CXNwZWMtPmlucHV0X211eCA9ICZhZDE5ODRfdGhpbmtwYWRfY2FwdHVyZV9zb3VyY2U7CiAJCXNw
ZWMtPm1peGVyc1swXSA9IGFkMTk4NF90aGlua3BhZF9taXhlcnM7CiAJCXNwZWMtPmluaXRfdmVy
YnNbc3BlYy0+bnVtX2luaXRfdmVyYnMrK10gPSBhZDE5ODRfdGhpbmtwYWRfaW5pdF92ZXJiczsK

------=_Part_14848_24107758.1198812175369
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_14848_24107758.1198812175369--
