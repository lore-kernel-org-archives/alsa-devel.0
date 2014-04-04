From: Gilles <gilles@whospot.com>
Subject: Audio codec with multiple I2C devices
Date: Fri, 4 Apr 2014 15:02:35 -0700
Message-ID: <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
References: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net
 (p3plsmtpa07-10.prod.phx3.secureserver.net [173.201.192.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DE0B2655A2
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 00:02:38 +0200 (CEST)
In-Reply-To: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Folks,

I'm writing an ALSA SoC codec which uses a 3 distinct I2C devices (a DAC, a CAG for volume and a input selector) all 3 at different I2C addresses. My existing code relies on DT to declare the primary I2C address (in this case the DAC) and it works. But I now need to add support for the extended functionality.

Can someone point me to the best way to declare the second I2C address in the DT and make use of it in the driver?

I know I could always hard code it and add a new i2c_new_device() in the probe() into the private data but I'm trying to make it a bit more DT friendly. Not having much luck on finding examples of this.

I'm attaching the existing code code below if anyone wants to reference to snipets of it. As you can see, the set/get volume are declared as _EXT since the volume is controlled by a secondary GC I2C device. Similarily, the input selector talks to a third I2C device.

Any help would be appreciated.  Thanks!




/*
//  ALSA SoC codec driver for Birdland Audio SDM-50 Digital Amplifier
//  Copyright (C) 2012 Birdland Audio - http://birdland.com
//  Author: Gilles Gameiro <gilles@whospot.com>
//
*/
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/i2c.h>
#include <linux/gpio.h>
#include <linux/of_gpio.h>
#include <linux/slab.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/initval.h>
#include <sound/tlv.h>


#define  DRV_NAME "sdm2x-audio-codec"
#define  BIRDLAND_MODEL_250     0

#define  SDM2X_REG0_VOLUME  0
#define  SDM2X_REG1_MUXCLK  1
#define   SDM2X_INPUT_EXTERNAL   0x80
#define   SDM2X_PLAYRATE_48000   0x08


#define SDM2X_RATES     (  SNDRV_PCM_RATE_32000 \
                         | SNDRV_PCM_RATE_44100 \
                         | SNDRV_PCM_RATE_48000 \
                         | SNDRV_PCM_RATE_64000 \
                         | SNDRV_PCM_RATE_88200 \
                         | SNDRV_PCM_RATE_96000 \
                         | SNDRV_PCM_RATE_176400 \
                         | SNDRV_PCM_RATE_192000 )

#define SDM2X_FORMATS  (   SNDRV_PCM_FMTBIT_S16_LE \
                         | SNDRV_PCM_FMTBIT_S20_3LE \
                         | SNDRV_PCM_FMTBIT_S24_3LE \
                         | SNDRV_PCM_FMTBIT_S32_LE )



/* codec private data */
struct sdm2x_priv {
  struct snd_soc_codec *codec;
  enum snd_soc_control_type control_type;
  u16 model;
  unsigned int sysclk;
  u8 input_cache;     // Caches the back panel input selected     (Controlled by AK4113)
  u8 volume_cache;    // Caches the current value of the volume   (Controlled by DAC121C085)
};


// FPGA I2C Slave IP is write only. Use register cache
#define SDM2X_RCACHE_SIZE  4
static const u8 sdm2x_reg_cache[SDM2X_RCACHE_SIZE] = {
  0x00, (SDM2X_INPUT_EXTERNAL | SDM2X_PLAYRATE_48000), 0x00, 0x00,
};




static int sdm250_get_volume(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
  struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);

  ucontrol->value.integer.value[0] = sdm2x->volume_cache;
  return 0;
}
static int sdm250_set_volume(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
  struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);
  int volume = ucontrol->value.integer.value[0] & 0x7f;

  sdm2x->volume_cache = volume;
  // TODO: Write it to GA

  return 0;
}



static int sdm250_get_input(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
  struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);

  ucontrol->value.integer.value[0] = sdm2x->input_cache;
  return 0;
}
static int sdm250_set_input(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
  struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);

  int input = ucontrol->value.integer.value[0] & 0x7f;
  sdm2x->input_cache = volume;
  // TODO: Write it to AK4113

  return 0;
}



/* General Volume -127dB to 0dB on 1dB steps */
static DECLARE_TLV_DB_SCALE(general_volume_tlv, -12700, 100, 0);

/* Enum declarations */
static const char *sdm2x_srcin[] = {"Internal", "External"};
static const struct soc_enum sdm2x_srcin_enum = SOC_ENUM_SINGLE(SDM2X_REG1_MUXCLK, 7, 2, sdm2x_srcin);

static const char *sdm2x_i2sin[] = {"Optical 1", "Optical 2", "Optical 3", "XLR" };
static const struct soc_enum sdm2x_i2sin_enum = SOC_ENUM_SINGLE(SDM2X_REG1_MUXCLK, 0, 3, sdm2x_i2sin);

static const struct snd_kcontrol_new sdm2x_snd_controls[] = {
  /* General Volume: This is set outside of the FPGA so use getter/setter functions */
  SOC_SINGLE_EXT_TLV("Amplifier Volume", SDM2X_REG0_VOLUME, 0, 127, 0, sdm250_get_volume, sdm250_set_volume, general_volume_tlv),
  /* FPGA Manged Controls (primary I2C of this driver) */
  SOC_SINGLE("Digital Mute", SDM2X_REG0_VOLUME, 7, 1, 0),   // TODO: Make this a DAI op?
  SOC_ENUM("SRC Input Source", sdm2x_srcin_enum),
  /* Back Pannel Controls (AK4113) */
  SOC_ENUM_EXT("Back Panel Input", sdm2x_i2sin_enum, sdm250_get_input, sdm250_set_input)
};




static int sdm2x_hw_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
{
  struct snd_soc_codec *codec = dai->codec;
  //struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);
  int fsref;
  unsigned char divreg;

  // Set Data word length not needed in I2S)
  fsref = params_format(params);

  // Set Sampling Rate: I haven't figured out how to make the mcasp I2S master for TX and slave for RX so let the FPGA generate the clocks Sampling Rate
  switch (fsref) {
    case SNDRV_PCM_RATE_32000:
      divreg = 0x0C;
      break;
    case SNDRV_PCM_RATE_44100:
    case SNDRV_PCM_RATE_48000:
      divreg = 0x08;
      break;
    case SNDRV_PCM_RATE_64000:
      divreg = 0x06;
      break;
    case SNDRV_PCM_RATE_88200:
    case SNDRV_PCM_RATE_96000:
      divreg = 0x04;
      break;
    case SNDRV_PCM_RATE_176400:
    case SNDRV_PCM_RATE_192000:
      divreg = 0x02;
      break;
    default:
      printk(KERN_ERR "sdm2x-codec.%s(): Requested rate 0x%08x not supported\n", __func__, fsref);
      return -EINVAL;
  }
  if (fsref % 11025 == 0) divreg |= 0x10;

  snd_soc_update_bits(codec, SDM2X_REG1_MUXCLK, 0x1F, divreg);

  return 0;
}



// DAI Ops

static int sdm2x_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
{
  //struct snd_soc_codec *codec = codec_dai->codec;
  //struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);

  // SDM-50 only supports vanilla I2S format.
  switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
    case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
      break;
    default:
      printk(KERN_ERR "sdm2x-codec.%s(): Requested Format 0x%08x not supported\n", __func__, (fmt & SND_SOC_DAIFMT_FORMAT_MASK));
      return -EINVAL;
  }

  // SDM-50 Uses normal I2S Clock polarities
  switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
    case SND_SOC_DAIFMT_NB_NF:
      break;
    default:
      printk(KERN_ERR "sdm2x-codec.%s(): Requested Clock Polarity 0x%08x not supported\n", __func__, (fmt & SND_SOC_DAIFMT_INV_MASK));
      return -EINVAL;
  }

  // And SDM-50 is the I2S Clock Master for both Bit and Frame
  switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
    case (SND_SOC_DAIFMT_CBM_CFM):
      break;
    default:
      printk(KERN_ERR "sdm2x-codec.%s(): Requested Master/Slave Clock 0x%08x not supported\n", __func__, (fmt & SND_SOC_DAIFMT_MASTER_MASK));
      return -EINVAL;
  }

  return 0;
}



static int sdm2x_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id, unsigned int freq, int dir)
{
  struct snd_soc_codec *codec = codec_dai->codec;
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);
  sdm2x->sysclk = freq;
  return 0;
}




static const struct snd_soc_dai_ops sdm2x_dai_ops = {
  .hw_params    = sdm2x_hw_params,
  .set_fmt      = sdm2x_set_dai_fmt,
  .set_sysclk   = sdm2x_set_dai_sysclk,
  //.digital_mute = sdm2x_mute,
};


static struct snd_soc_dai_driver sdm2x_dai = {
  .name = "sdm2x-hifi",
  .playback = {
    .stream_name = "Playback",
    .channels_min = 1,
    .channels_max = 2,
    .rates = SDM2X_RATES,
    .formats = SDM2X_FORMATS,
  },
  .capture = {
    .stream_name = "Capture",
    .channels_min = 1,
    .channels_max = 2,
    .rates = SDM2X_RATES,
    .formats = SDM2X_FORMATS,
  },
  .ops = &sdm2x_dai_ops,
  .symmetric_rates = 1,
};



static int sdm2x_suspend(struct snd_soc_codec *codec)
{
  return 0;
}

static int sdm2x_resume(struct snd_soc_codec *codec)
{
  return 0;
}




/* PROBE: Setup private data, initialize codec and attach it to ASoC */
static int sdm2x_probe(struct snd_soc_codec *codec)
{
  int ret;
  struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);

  sdm2x->codec = codec;

  // This belongs in the core but not sure if 3.8.13 supports it already..
  ret = snd_soc_codec_set_cache_io(codec, 8, 8, sdm2x->control_type);
  if (ret != 0) {
    printk(KERN_ERR "sdm2x-codec.%s(): Failed to set cache I/O: %d\n", __func__, ret);
    return ret;
  }

  //codec->cache_only = 1;

  // Init...
  snd_soc_write(codec, SDM2X_REG0_VOLUME, 0);
  snd_soc_write(codec, SDM2X_REG1_MUXCLK, (SDM2X_INPUT_EXTERNAL | SDM2X_PLAYRATE_48000));
  //snd_soc_update_bits(codec, SDM250_REG2_STATUS, SOFT_RESET, SOFT_RESET);  // Auto Clears after reset complete (might not work with cached registers)

  // Add AMIXER controls (Volume, etc..)
  snd_soc_add_codec_controls(codec, sdm2x_snd_controls, ARRAY_SIZE(sdm2x_snd_controls));

  return 0;
}


static int sdm2x_remove(struct snd_soc_codec *codec)
{
  // struct sdm2x_priv *sdm2x = snd_soc_codec_get_drvdata(codec);
  // TODO: Where is private data freed up?
  return 0;
}


static struct snd_soc_codec_driver soc_codec_dev_sdm2x = {
  .reg_cache_size = ARRAY_SIZE(sdm2x_reg_cache),
  .reg_word_size = sizeof(u8),
  .reg_cache_default = sdm2x_reg_cache,
  .probe = sdm2x_probe,
  .remove = sdm2x_remove,
  .suspend = sdm2x_suspend,
  .resume = sdm2x_resume,
};



static const struct i2c_device_id sdm2x_i2c_id[] = {
    { "sdm2x", BIRDLAND_MODEL_250 },
    { }
};
MODULE_DEVICE_TABLE(i2c, sdm2x_i2c_id);


/* If the i2c layer weren't so broken, we could pass this kind of data around */
static int sdm2x_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
{
  struct sdm2x_priv *sdm2x;
  struct device_node *np = i2c->dev.of_node;
  int ret;

  sdm2x = devm_kzalloc(&i2c->dev, sizeof(struct sdm2x_priv), GFP_KERNEL);
  if (sdm2x == NULL) {
    printk(KERN_ERR "sdm2x-codec.%s(): Failed to set cache I/O\n", __func__);
    return -ENOMEM;
  }

  // This driver doesn't support the old style platform data
  if (!np) {
    printk(KERN_ERR "sdm2x-codec.%s(): missing DT data info\n", __func__);
    return -EINVAL;
  }

  sdm2x->control_type = SND_SOC_I2C;

  i2c_set_clientdata(i2c, sdm2x);

  sdm2x->model = id->driver_data;

  ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_sdm2x, &sdm2x_dai, 1);
  return ret;
}

static int sdm2x_i2c_remove(struct i2c_client *client)
{
  // TODO: Where is private data freed up?
  snd_soc_unregister_codec(&client->dev);
  return 0;
}

#if defined(CONFIG_OF)
static const struct of_device_id sdm2x_of_match[] = {
  { .compatible = "birdland,sdm2x", },
  {},
};
MODULE_DEVICE_TABLE(of, sdm2x_of_match);
#endif

/* machine i2c codec control layer */
static struct i2c_driver sdm2x_i2c_driver = {
  .driver = {
    .name = "sdm2x-codec",
    .owner = THIS_MODULE,
    .of_match_table = of_match_ptr(sdm2x_of_match),
  },
  .probe = sdm2x_i2c_probe,
  .remove = sdm2x_i2c_remove,
  .id_table = sdm2x_i2c_id,
};

module_i2c_driver(sdm2x_i2c_driver);

MODULE_DESCRIPTION("ASoC SDM2x codec driver");
MODULE_AUTHOR("Gilles Gameiro");
MODULE_LICENSE("GPL");
