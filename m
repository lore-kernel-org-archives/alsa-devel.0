From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: simple-card: Fix refcount underflow
Date: Sat, 16 Feb 2019 10:09:42 +0000
Message-ID: <20190216100927.10017-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "broonie@kernel.org" <broonie@kernel.org>, "vicencb@gmail.com" <vicencb@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

of_get_child_by_name() takes a reference we'll need to drop
later so when we substitute in top we need to take a reference
as well as just assigning.

Without this patch we hit the following error:

[    1.246852] OF: ERROR: Bad of_node_put() on /sound-wm8524
[    1.262261] Hardware name: NXP i.MX8MQ EVK (DT)
[    1.266807] Workqueue: events deferred_probe_work_func
[    1.271950] Call trace:
[    1.274406]  dump_backtrace+0x0/0x158
[    1.278074]  show_stack+0x14/0x20
[    1.281396]  dump_stack+0xa8/0xcc
[    1.284717]  of_node_release+0xb0/0xc8
[    1.288474]  kobject_put+0x74/0xf0
[    1.291879]  of_node_put+0x14/0x28
[    1.295286]  __of_get_next_child+0x44/0x70
[    1.299387]  of_get_next_child+0x3c/0x60
[    1.303315]  simple_for_each_link+0x1dc/0x230
[    1.307676]  simple_probe+0x80/0x540
[    1.311256]  platform_drv_probe+0x50/0xa0

This patch is based on an earlier version posted by Kuninori Morimoto
and commit message includes explanations from Mark Brown.

https://patchwork.kernel.org/patch/10814255/

Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-car=
d.c
index 08df261024cf..dc18c4492955 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *pri=
v,
 	/* Check if it has dai-link */
 	node =3D of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
-		node =3D top;
+		node =3D of_node_get(top);
 		is_top =3D 1;
 	}
=20
--=20
2.17.1
