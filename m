From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#596478: [PATCH] ALSA: emux: Add trivial compat ioctl handler
Date: Sun, 12 Sep 2010 02:41:47 +0100
Message-ID: <1284255707.5323.638.camel@localhost>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 596478@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.596478.B596478.128425572113929@bugs.debian.org>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Carmen Cru <carmen.cru@belgacom.net>, 596478@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Reported-by: Carmen Cru <carmen.cru@belgacom.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is compile-tested only.

Ben.

 sound/synth/emux/emux_hwdep.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index ff0b2a8..5ae1eae 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -128,6 +128,9 @@ snd_emux_init_hwdep(struct snd_emux *emu)
 	strcpy(hw->name, SNDRV_EMUX_HWDEP_NAME);
 	hw->iface =3D SNDRV_HWDEP_IFACE_EMUX_WAVETABLE;
 	hw->ops.ioctl =3D snd_emux_hwdep_ioctl;
+	/* The ioctl parameter types are compatible between 32- and
+	 * 64-bit architectures, so use the same function. */
+	hw->ops.ioctl_compat =3D snd_emux_hwdep_ioctl;
 	hw->exclusive =3D 1;
 	hw->private_data =3D emu;
 	if ((err =3D snd_card_register(emu->card)) < 0)
--=20
1.7.1
