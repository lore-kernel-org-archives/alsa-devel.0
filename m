From: "Matt Mullins" <mokomull@gmail.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Thu, 5 Jul 2007 21:42:21 -0500
Message-ID: <dfd4051f0707051942n699f69cava8a9d83b3bae5e1@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<dfd4051f0706201418o4d19a1f2g78081b052e8766e4@mail.gmail.com>
	<s5hd4zpa9d9.wl%tiwai@suse.de>
	<dfd4051f0706221331r681503d7h9d755bd91750a8ec@mail.gmail.com>
	<s5hejk0ibhj.wl%tiwai@suse.de>
	<dfd4051f0706251316uf265b3dw9c069dc5f75ceedf@mail.gmail.com>
	<s5hsl8deffy.wl%tiwai@suse.de>
	<dfd4051f0707041337m276d5536r6c65fd6d29463f39@mail.gmail.com>
	<s5hvecz5cz3.wl%tiwai@suse.de>
	<dfd4051f0707051513p697f22a2p4e34d9910f44f15e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_136493_25409735.1183689741756"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 9004B1038F2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 04:42:22 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so626576ugf
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2007 19:42:22 -0700 (PDT)
In-Reply-To: <dfd4051f0707051513p697f22a2p4e34d9910f44f15e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_136493_25409735.1183689741756
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Found what I think is the problem... patch_sigmatel.c set
spec->num_pins=14, yet spec->pin_nids pointed to stac9205_pin_nids,
which was an array of only 12 NIDs.  That caused [total guess here]
either stac92xx_save_bios_config_regs or stac92xx_set_config_regs to
read past the end of the array and into an uninitialized area.  I
changed the 14 to a 12, and it seems to work.  The attached patch is
against the current Mercurial sources, but I made the similar change
to kernel 2.6.22-rc7, and it doesn't use single_cmd anymore.  It still
doesn't work after a suspend, though, making me unload and reload the
module.

------=_Part_136493_25409735.1183689741756
Content-Type: application/octet-stream; name=patch_mokomull
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3s2aayi
Content-Disposition: attachment; filename="patch_mokomull"

LS0tIGFsc2Eta2VybmVsLXN0b2NrL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwkyMDA3LTA3LTA1
IDIwOjQ0OjQ2LjAwMDAwMDAwMCAtMDUwMAorKysgYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9z
aWdtYXRlbC5jCTIwMDctMDctMDUgMjA6MzQ6MjMuMDAwMDAwMDAwIC0wNTAwCkBAIC0yMjU5LDcg
KzIyNTksNyBAQAogCQlyZXR1cm4gLUVOT01FTTsKIAogCWNvZGVjLT5zcGVjID0gc3BlYzsKLQlz
cGVjLT5udW1fcGlucyA9IDE0OworCXNwZWMtPm51bV9waW5zID0gMTI7CiAJc3BlYy0+cGluX25p
ZHMgPSBzdGFjOTIwNV9waW5fbmlkczsKIAlzcGVjLT5ib2FyZF9jb25maWcgPSBzbmRfaGRhX2No
ZWNrX2JvYXJkX2NvbmZpZyhjb2RlYywgU1RBQ185MjA1X01PREVMUywKIAkJCQkJCQlzdGFjOTIw
NV9tb2RlbHMsCg==
------=_Part_136493_25409735.1183689741756
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_136493_25409735.1183689741756--
