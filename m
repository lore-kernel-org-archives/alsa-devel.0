From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: SGTL500 and its external MCLK
Date: Thu, 7 Aug 2014 15:37:47 -0400
Message-ID: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F08026530D
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 21:37:48 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id l4so3113126lbv.16
 for <alsa-devel@alsa-project.org>; Thu, 07 Aug 2014 12:37:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, zengzm.kernel@gmail.com
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

For testing purposes I have a SGTL5000 wired up to I2S on my Allwinner
A20.  SGTL5000 needs an external MCLK. It attaches to it like this:

sgtl5000: sgtl5000@a {
   compatible = "fsl,sgtl5000";
   reg = <0x0a>;
   clocks = <&iis0>;

And in the probe code....
(this should use a name for the clock in the DTS)

sgtl5000->mclk = devm_clk_get(&client->dev, NULL);
if (IS_ERR(sgtl5000->mclk)) {
   ret = PTR_ERR(sgtl5000->mclk);
   dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
   /* Defer the probe to see if the clk will be provided later */
   if (ret == -ENOENT)
      return -EPROBE_DEFER;
   return ret;
}

ret = clk_prepare_enable(sgtl5000->mclk);
if (ret)
   return ret;

So the sgtl5000 driver has a handle to the clock. But then the driver
implements set_dai_sysclk() to get the rate. And a board specific
machine driver like imx-sgtl5000.c is used to set this rate into the
sgtl5000 driver.

/* set codec sysclk */
static int sgtl5000_set_dai_sysclk(struct snd_soc_dai *codec_dai,
  int clk_id, unsigned int freq, int dir)
{
   struct snd_soc_codec *codec = codec_dai->codec;
   struct sgtl5000_priv *sgtl5000 =      snd_soc_codec_get_drvdata(codec);

switch (clk_id) {
   case SGTL5000_SYSCLK:
   sgtl5000->sysclk = freq;
      break;
default:
   return -EINVAL;
  }

  return 0;
}

Since the sgtl5000 driver has the handle to the clock, can't it just
ask the clock for its rate? If it directly asked the clock for its
rate it looks like this codec could be bound with simple-audio-card
and not need a machine driver.

-- 
Jon Smirl
jonsmirl@gmail.com
