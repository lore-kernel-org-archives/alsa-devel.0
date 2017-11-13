From: Johan Hovold <johan@kernel.org>
Subject: Broken child-node lookup in sound/soc/mediatek/mt8173
Date: Mon, 13 Nov 2017 12:32:52 +0100
Message-ID: <20171113113252.GT11226@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A75F4267326
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 12:32:47 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id s16so17698065lfs.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 03:32:47 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, PC Liao <pc.liao@mediatek.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to fix up incorrect usage of of_find_node_by_name() to lookup
child nodes, and found the following code in
sound/soc/mediatek/mt8173/mt8173-rt5650.c:

static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
{
	...

	platform_node = of_parse_phandle(pdev->dev.of_node,
					 "mediatek,platform", 0);
	...

	if (of_find_node_by_name(platform_node, "codec-capture")) {
		np = of_get_child_by_name(pdev->dev.of_node, "codec-capture");
		if (!np) {
			dev_err(&pdev->dev,
				"%s: Can't find codec-capture DT node\n",
				__func__);
			return -EINVAL;
		}
		ret = snd_soc_of_get_dai_name(np, &codec_capture_dai);
		if (ret < 0) {
			dev_err(&pdev->dev,
				"%s codec_capture_dai name fail %d\n",
				__func__, ret);
			return ret;
		}
		mt8173_rt5650_codecs[1].dai_name = codec_capture_dai;
	}

added by commit d349caeb0510 ("ASoC: mediatek: Add second I2S on
mt8173-rt5650 machine driver").

First of all the "codec-capture" node is indeed documented as a child
node of the sound node, so the tree-wide depth-first search from the
platform_node looks entirely bogus.

Note that of_find_node_by_name() also drops a reference to its first
argument, in this case the sound node, which could end up being
prematurely freed. 

And then the reference to any returned codec-capture node (from either
lookup) is never dropped.

And since support for this second codec was added retrospectively and is
documented as optional, that -EINVAL in case the node is missing looks
broken too.

I figured I better just report this one to the author of the patch and
the maintainers to be straightened out.

Thanks,
Johan
