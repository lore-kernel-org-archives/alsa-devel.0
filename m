From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Thu, 09 Apr 2015 09:39:09 +0200
Message-ID: <55262C9D.5080005@metafoo.de>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>	<55258272.2010205@metafoo.de>
 <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A4A261600
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 09:39:09 +0200 (CEST)
In-Reply-To: <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On 04/08/2015 10:35 PM, Fabio Estevam wrote:
> On Wed, Apr 8, 2015 at 4:33 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> Does the card name contain a '/' like in 'S/PDIF'?
>
> Yes, it does. I also tried to change it like this:
>
> --- a/sound/soc/fsl/imx-spdif.c
> +++ b/sound/soc/fsl/imx-spdif.c
> @@ -37,8 +37,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
>                  goto end;
>          }
>
> -       data->dai.name = "S/PDIF PCM";
> -       data->dai.stream_name = "S/PDIF PCM";
> +       data->dai.name = "SPDIF PCM";
> +       data->dai.stream_name = "SPDIF PCM";
>          data->dai.codec_dai_name = "snd-soc-dummy-dai";
>          data->dai.codec_name = "snd-soc-dummy";
>          data->dai.cpu_of_node = spdif_np;
>
> ,but I still get the warning.

That's the DAI name, which could cause problems on its own. But not the one 
you are seeing right now.

The whole thing is a bit confusing. The message you get is what you'd get if 
the 'dapm' sub-directory in the card debugfs directory can not be created. 
One of the few reasons why it would fail is if it already existed, but we 
should never register two dapm contexts for the card, so that's a bit 
strange. One of the few reasons I can imagine this could happen is if the 
parent directory could not be created and now we try to create multiple dapm 
directories at the top-level.

Try to do some more debugging and see why and where exactly things go wrong. 
Can you also try this:

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b6f8820..7810262 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1898,6 +1898,11 @@
  {
  	struct dentry *d;

+	if (!parent) {
+		dev_warn(dapm->dev, "No debugfs parent!\n");
+		return;
+	}
+
  	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);

  	if (!dapm->debugfs_dapm) {
