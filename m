From: Rob Nertney <rob@rob-otics.com>
Subject: Custom card returns "arecord: main:722: audio open
	error: Invalid argument"
Date: Thu, 26 May 2016 23:43:08 -0700
Message-ID: <CALAeOVPgNxX-0OeDm7a+Y2OMa7XHZ9SnZ4czHbKo9Uzdfayb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 509452652D7
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 08:43:10 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id x130so9471438oia.3
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 23:43:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've build a card that is registered correctly as far as I can tell.

My hardware is:
static struct snd_pcm_hardware my_pcm_hw =
{
  .info = (SNDRV_PCM_INFO_MMAP |
      SNDRV_PCM_INFO_BLOCK_TRANSFER |
      SNDRV_PCM_INFO_MMAP_VALID),
  .formats          = SNDRV_PCM_FMTBIT_U8,
  .rates            = SNDRV_PCM_RATE_8000,
  .rate_min         = 8000,
  .rate_max         = 8000,
  .channels_min     = 1,
  .channels_max     = 1,
  .buffer_bytes_max = DMA_LENGTH,
  .period_bytes_min = 48,
  .period_bytes_max = 48,
  .periods_min      = 1,
  .periods_max      = 16,
};

When I run "arecord -d 2 foo.wav", I get the error message in the subject.
Printks show that I get to my_pcm_open, then immediately jump to
my_hw_free, my_pcm_close.

I'm in an FPGA embedded system. there are no other cards but mine via
arecord -L.

Here's my _init function for the module:
 struct snd_card *card;
  struct aaw_device *my_dev;
  struct snd_pcm *pcm;
  struct device *dev;
  int ret;

  printk(KERN_ERR "INIT start\n");
  snd_card_new(dev,SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1, THIS_MODULE,
sizeof(struct my_device), &card);
  my_dev = card->private_data;
  my_dev->card = card;

  sprintf(card->driver, "my_driver");
  sprintf(card->shortname, "My First Audio Driver");

  snd_card_set_dev(card,dev);

  ret = snd_device_new(card, SNDRV_DEV_LOWLEVEL, my_dev, &dev_ops);
  if(ret < 0)
    printk(KERN_ERR "new device err\n");
  ret = snd_pcm_new(card, card->driver, 0, 0, 1, &pcm);
  if(ret < 0)
    printk(KERN_ERR "new pcm err\n");

  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &my_pcm_ops);

  pcm->private_data = my_dev;
  pcm->info_flags = 0;
  strcpy(pcm->name, card->shortname);

  ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
      SNDRV_DMA_TYPE_CONTINUOUS,
      snd_dma_continuous_data(GFP_KERNEL),
      DMA_LENGTH, DMA_LENGTH);
  if(ret < 0)
    printk(KERN_ERR "preallocate page err\n");

  ret = snd_card_register(card);
  if (ret < 0)
    printk(KERN_ERR "error in register snd\n");


Here's my _open function:
static int my_pcm_open(struct snd_pcm_substream *ss)
{
  struct my_device *my_dev = ss->private_data;

  printk(KERN_ERR "in pcm_open\n");
  ss->runtime->hw = my_pcm_hw;

  my_dev->substream = ss;
  ss->runtime->private_data = my_dev;
  return 0;
}

Any help would be most appreciated.

Thanks,
Rob
