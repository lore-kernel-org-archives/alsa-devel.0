From: Giuliano Pochini <pochini@shiny.it>
Subject: hw_rule
Date: 08 May 2003 23:19:28 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052435969.2728.15.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I wrote this rule:


static int hw_rule_format_set_channels(snd_pcm_hw_params_t *params,
snd_pcm_hw_rule_t *rule) {
  snd_interval_t *c=hw_param_interval(params,
SNDRV_PCM_HW_PARAM_CHANNELS);
  snd_mask_t *f=hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
  snd_interval_t ch;

  printk("Rule f=%x %x %x\n", f->bits[0], f->bits[1], f->bits[2]);
  memset(&ch, 0, sizeof(ch));

  // S32_BE is mono only
  if (f->bits[0]==SNDRV_PCM_FMTBIT_S32_BE) {
    ch.min=1;
    ch.max=1;
    ch.integer=1;
    return(snd_interval_refine(c, &ch));
  }
  // U8 and S16_LE are stereo only
  if (f->bits[0]==SNDRV_PCM_FMTBIT_U8 ||
      f->bits[0]==SNDRV_PCM_FMTBIT_S16_LE) {
    ch.min=2;
    ch.max=2;
    ch.integer=1;
    return(snd_interval_refine(c, &ch));
  }
  // S32_LE supports any number of channels.
  return(0);
}


It seems to work, but since it's based on other drivers (no docs...),
there are some thing I don't know:
- Is f->bits[0] correct ?  All formats supported by the card are < 31. I
suppose formats >=32 go in bits[1], isn't it ?
- what are ch.openmin, openmax, empty ?  They are taken into account
because if I don't clear the structure the rule doesn't work anymore.
- How many stupid bugs are there ? :)


Bye.




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
