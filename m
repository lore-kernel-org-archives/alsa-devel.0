From: "Jerone Young" <jerone@gmail.com>
Subject: [PATCH] Remove psuedo master from
	pci/hda/analog_patch.c . It does not function well!
Date: Fri, 25 Jan 2008 01:11:38 -0600
Message-ID: <9f50a7a00801242311i3fe64fecw70ee75c4b6070359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_28380_32112085.1201245098649"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FAC424724
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 08:11:39 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so486521fgb.44
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 23:11:38 -0800 (PST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

------=_Part_28380_32112085.1201245098649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi I noticed after installing 1.0.16rc-1 today that my Thinkpad T61
with AD1984 had a Master mixer now. Problem is it's not very good in
that it
1) does not follow with PCM (the real master) volume well. It causes a
volume disparity and does not
   follow or even boost PCM signal. So it just a bad mister.
2) it does not mute the volume (since PCM is the real master mixer you
have to go to PCM to mute the volume!)

I have fixed a problem in Gstreamer so that Gnome (gnome volume mixer)
does finally work correctly for the AD1984 which does not have a
Master. When it looks for a master mixer it now will fallback to PCM
as a master mixer (the code is upsteam too). You can find this here:

http://bugzilla.gnome.org/show_bug.cgi?id=506928

I have a feeling this is why this patch was put in. I have fixed the
problem in Gnome, KDE has allways worked. just fine.

But I would honestly love it if this code was removed!!! If you need a
Master can you rename PCM to master for the AD1984! I have attached a
patch to remove this code .. because it is so does not function well!

Signed-off-by : Jerone Young <jerone@gmail.com>

diff -r 5dfc8324ae17 alsa-kernel/pci/hda/patch_analog.c
--- a/alsa-kernel/pci/hda/patch_analog.c	Fri Jan 25 00:12:14 2008 -0600
+++ b/alsa-kernel/pci/hda/patch_analog.c	Fri Jan 25 01:04:13 2008 -0600
@@ -170,26 +170,6 @@ static int ad198x_build_controls(struct
 	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
-		if (err < 0)
-			return err;
-	}
-
-	/* if we have no master control, let's create it */
-	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
-		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
-					HDA_OUTPUT, spec->vmaster_tlv);
-		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
-					  spec->vmaster_tlv,
-					  (spec->slave_vols ?
-					   spec->slave_vols : ad_slave_vols));
-		if (err < 0)
-			return err;
-	}
-	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
-		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
-					  NULL,
-					  (spec->slave_sws ?
-					   spec->slave_sws : ad_slave_sws));
 		if (err < 0)
 			return err;
 	}

------=_Part_28380_32112085.1201245098649
Content-Type: text/x-patch; name=remove_sudo_master.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbue54v90
Content-Disposition: attachment; filename=remove_sudo_master.patch

ZGlmZiAtciA1ZGZjODMyNGFlMTcgYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYwot
LS0gYS9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCUZyaSBKYW4gMjUgMDA6MTI6
MTQgMjAwOCAtMDYwMAorKysgYi9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCUZy
aSBKYW4gMjUgMDE6MDQ6MTMgMjAwOCAtMDYwMApAQCAtMTcwLDI2ICsxNzAsNiBAQCBzdGF0aWMg
aW50IGFkMTk4eF9idWlsZF9jb250cm9scyhzdHJ1Y3QgCiAJfSAKIAlpZiAoc3BlYy0+ZGlnX2lu
X25pZCkgewogCQllcnIgPSBzbmRfaGRhX2NyZWF0ZV9zcGRpZl9pbl9jdGxzKGNvZGVjLCBzcGVj
LT5kaWdfaW5fbmlkKTsKLQkJaWYgKGVyciA8IDApCi0JCQlyZXR1cm4gZXJyOwotCX0KLQotCS8q
IGlmIHdlIGhhdmUgbm8gbWFzdGVyIGNvbnRyb2wsIGxldCdzIGNyZWF0ZSBpdCAqLwotCWlmICgh
c25kX2hkYV9maW5kX21peGVyX2N0bChjb2RlYywgIk1hc3RlciBQbGF5YmFjayBWb2x1bWUiKSkg
ewotCQlzbmRfaGRhX3NldF92bWFzdGVyX3Rsdihjb2RlYywgc3BlYy0+dm1hc3Rlcl9uaWQsCi0J
CQkJCUhEQV9PVVRQVVQsIHNwZWMtPnZtYXN0ZXJfdGx2KTsKLQkJZXJyID0gc25kX2hkYV9hZGRf
dm1hc3Rlcihjb2RlYywgIk1hc3RlciBQbGF5YmFjayBWb2x1bWUiLAotCQkJCQkgIHNwZWMtPnZt
YXN0ZXJfdGx2LAotCQkJCQkgIChzcGVjLT5zbGF2ZV92b2xzID8KLQkJCQkJICAgc3BlYy0+c2xh
dmVfdm9scyA6IGFkX3NsYXZlX3ZvbHMpKTsKLQkJaWYgKGVyciA8IDApCi0JCQlyZXR1cm4gZXJy
OwotCX0KLQlpZiAoIXNuZF9oZGFfZmluZF9taXhlcl9jdGwoY29kZWMsICJNYXN0ZXIgUGxheWJh
Y2sgU3dpdGNoIikpIHsKLQkJZXJyID0gc25kX2hkYV9hZGRfdm1hc3Rlcihjb2RlYywgIk1hc3Rl
ciBQbGF5YmFjayBTd2l0Y2giLAotCQkJCQkgIE5VTEwsCi0JCQkJCSAgKHNwZWMtPnNsYXZlX3N3
cyA/Ci0JCQkJCSAgIHNwZWMtPnNsYXZlX3N3cyA6IGFkX3NsYXZlX3N3cykpOwogCQlpZiAoZXJy
IDwgMCkKIAkJCXJldHVybiBlcnI7CiAJfQo=
------=_Part_28380_32112085.1201245098649
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_28380_32112085.1201245098649--
