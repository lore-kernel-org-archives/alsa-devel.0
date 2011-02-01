From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: ALSA 1.0.24 warning when compiling on 32bits machine
Date: Tue, 1 Feb 2011 10:50:26 +0800
Message-ID: <AANLkTi=xG9rkAH80gKS-8nFF=YMZapvN9+XqoHBPsU27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BD356245D0
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 03:50:29 +0100 (CET)
Received: by eyg24 with SMTP id 24so2766896eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 18:50:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  CC [M]  /alsa-driver-1.0.24/acore/pcm_native.o
/alsa-driver-1.0.24/acore/pcm_native.c: In function =91snd_pcm_mmap_status=
=92:
/alsa-driver-1.0.24/acore/pcm_native.c:3171: warning: assignment discards
qualifiers from pointer target type
/alsa-driver-1.0.24/acore/pcm_native.c: In function =91snd_pcm_mmap_control=
=92:
/allsa-driver-1.0.24/acore/pcm_native.c:3255: warning: assignment discards
qualifiers from pointer target type
/alsa-driver-1.0.24/acore/pcm_native.c: In function =91snd_pcm_default_mmap=
=92:
/allsa-driver-1.0.24/acore/pcm_native.c:3437: warning: assignment discards
qualifiers from pointer target type
/alsa-driver-1.0.24/acore/pcm_native.c: In function =91snd_pcm_mmap_data=92:
/alsa-driver-1.0.24/acore/pcm_native.c:3524: warning: assignment discards
qualifiers from pointer target type


CC [M]  /alsa-driver-1.0.24/pci/emu10k1/emufx.o
In file included from
/home/raymond/alsa-driver-1.0.24/pci/emu10k1/emufx.c:3:
/alsa-driver-1.0.24/pci/emu10k1/../../alsa-kernel/pci/emu10k1/emufx.c: In
function =91__check_high_res_gpr_volume=92:
/alsa-driver-1.0.24/pci/emu10k1/../../alsa-kernel/pci/emu10k1/emufx.c:55:
warning: return from incompatible pointer type


CC [M]  /alsa-driver-1.0.24/pci/hda/patch_hdmi.o
In file included from
/home/raymond/alsa-driver-1.0.24/pci/hda/patch_hdmi.c:3:
/alsa-driver-1.0.24/pci/hda/../../alsa-kernel/pci/hda/patch_hdmi.c: In
function =91__check_static_hdmi_pcm=92:
/alsa-driver-1.0.24/pci/hda/../../alsa-kernel/pci/hda/patch_hdmi.c:40:
warning: return from incompatible pointer type


CC [M]  /alsa-driver-1.0.24/usb/usx2y/us122l.o
In file included from /allsa-driver-1.0.24/usb/usx2y/us122l.c:2:
/alsa-driver-1.0.24/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c: In
function =91usb_stream_hwdep_mmap=92:
/alsa-driver-1.0.24/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c:263:
warning: assignment discards qualifiers from pointer target type
  CC [M]  /alsa-driver-1.0.24/usb/usx2y/usbusx2y.o
  CC [M]  /alsa-driver-1.0.24/usb/usx2y/usX2Yhwdep.o
/alsa-driver-1.0.24/usb/usx2y/usX2Yhwdep.c: In function
=91snd_us428ctls_mmap=92:
/alsa-driver-1.0.24/usb/usx2y/usX2Yhwdep.c:144: warning: assignment discards
qualifiers from pointer target type
  CC [M]  /alsa-driver-1.0.24/usb/usx2y/usx2yhwdeppcm.o
/alsa-driver-1.0.24/usb/usx2y/usx2yhwdeppcm.c: In function
=91snd_usX2Y_hwdep_pcm_mmap=92:
/alsa-driver-1.0.24/usb/usx2y/usx2yhwdeppcm.c:805: warning: assignment
discards qualifiers from pointer target type
