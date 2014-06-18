From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] *** ASoC: core: refine of node id parse of
	cpu/codec dai ***
Date: Wed, 18 Jun 2014 19:01:58 +0800
Message-ID: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 583562617A6
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 13:02:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, zhangfei.gao@gmail.com, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam

This patch is to add another check besides cpu_dai/codec_dai name during
dai_link bind. currently if the cpu_dai/codec_dai name match corresponding
dai_link cpu/codec name, then a match is found. in this patch, it also checks
whether cpu/codec dai id match dailink cpu_dai_id/codec_dai_id. Still check
name first.
1. if it doesn't match, it will keep checking whether cpu_id/codec_id match
corresponding dai_link cpu_dai_id/codec_dai_id. if the ids are equal, then
a match is found.
2. if it does match, then a match is already found. no need to further check.

By this way, it's convenient to maintain dai_link in DT files, and machine
driver can parse related node point to get dai id info. Then there is no need
to parse cpu_dai/codec_dai name for each dai. Like below:

In DT files:
sound {
	compatible = "sound card name xx";
	dai_link_1:dai_link_1 {
		compatible = "xx-dailink-1";
		cpu-dai = <&cpu-dai-node CPU_DAI_ID_1>;
		codec-dai = <&codec-dai-node CODEC_DAI_ID_1>;
		......
	}

	dai_link_2:dai_link_2 {
		compatible = "xx-dailink-2";
		cpu-dai = <&cpu-dai-node CPU_DAI_ID_2>;
		codec-dai = <&codec-dai-node CODEC_DAI_ID_2>;
		......
	}
	......
}

In machine driver:
static xx_sound_card_probe(struct platform_device *pdev)
{
	struct device_node *np = pdev->dev.of_node;

	i = 0;
	for_each_child_of_node(np, dailink_np) {
		of_parse_phandle_with_args(dailink_np, "cpu-dai", "#dailink-cells", 0,
&out_args);
		dailink[i].cpu_of_node = out_args.np;
		dailink[i].cpu_dai_id = out_args.args[0];
		dailink[i].platform_of_node = out_args.np;

		of_parse_phandle_with_args(dailink_np, "codec-dai", "#dailink-cells", 0,
&out_args);
		dailink[i].codec_of_node = out_args.np;
		dailink[i].codec_dai_id = out_args.args[0];
		......
		i++
	}
	......
	ret = snd_soc_register_card(card);
	......
}

If some drivers don't have DT support, then we have no choice but to add correct
cpu/codec(dai) name in DT and parse name info in machine driver.

Could you help share your opinions? Thanks in advance.

Qiao Zhou (1):
  ASoC: core: refine of node id parse of cpu/codec dai

 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   32 +++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
1.7.9.5
