From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: dapm: Use struct_size() in krealloc()
Date: Thu, 23 May 2019 15:36:37 -0500
Message-ID: <20190523203637.GA14197@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with
memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = krealloc(instance, sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, use the new
struct_size() helper:

instance = krealloc(instance, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b71ddaca70e5..511ed84b147b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -487,7 +487,8 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 		n = 1;
 
 	new_wlist = krealloc(data->wlist,
-			sizeof(*new_wlist) + sizeof(widget) * n, GFP_KERNEL);
+			     struct_size(new_wlist, widgets, n),
+			     GFP_KERNEL);
 	if (!new_wlist)
 		return -ENOMEM;
 
-- 
2.21.0
