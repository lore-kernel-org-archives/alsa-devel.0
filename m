From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: Add EQ and filter to max98095 CODEC
	driver
Date: Mon, 13 Nov 2017 13:25:16 +0300
Message-ID: <20171113102516.5b5nc3eq24yptksw@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D3826698E
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:25:32 +0100 (CET)
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
To: cdefgab1288@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[  This is an old patch.  I'm working on some new Smatch stuff and I'm
   looking at this code, and I don't see how it's possible for this code
   to work.  I must be missing something and it would help me if someone
   could explain to me what's going on so I can fix my software.  - dan ]

Hello Peter Hsiang,

The patch dad31ec133ad: "ASoC: Add EQ and filter to max98095 CODEC
driver" from Apr 19, 2011, leads to the following static checker
warning:

	sound/soc/codecs/max98095.c:1524 max98095_put_eq_enum()
	warn: constraint overflow 'max98095->eq_texts'
		required = '(struct max98095_priv)->eq_textcnt'

The error message is saying that Smatch expects we should verify that
the index into the max98095->eq_texts[] array is less than
max98095->eq_textcnt.

sound/soc/codecs/max98095.c
  1494  static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
  1495                                   struct snd_ctl_elem_value *ucontrol)
  1496  {
  1497          struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
  1498          struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
  1499          struct max98095_pdata *pdata = max98095->pdata;
  1500          int channel = max98095_get_eq_channel(kcontrol->id.name);
  1501          struct max98095_cdata *cdata;
  1502          unsigned int sel = ucontrol->value.enumerated.item[0];
  1503          struct max98095_eq_cfg *coef_set;
  1504          int fs, best, best_val, i;
  1505          int regmask, regsave;
  1506  
  1507          if (WARN_ON(channel > 1))
  1508                  return -EINVAL;
  1509  
  1510          if (!pdata || !max98095->eq_textcnt)
                              ^^^^^^^^^^^^^^^^^^^^^

Here we check that max98095->eq_textcnt is non-zero.

  1511                  return 0;
  1512  
  1513          if (sel >= pdata->eq_cfgcnt)
                    ^^^^^^^^^^^^^^^^^^^^^^^
Check here

  1514                  return -EINVAL;
  1515  
  1516          cdata = &max98095->dai[channel];
  1517          cdata->eq_sel = sel;
  1518          fs = cdata->rate;
  1519  
  1520          /* Find the selected configuration with nearest sample rate */
  1521          best = 0;
  1522          best_val = INT_MAX;
  1523          for (i = 0; i < pdata->eq_cfgcnt; i++) {
                                ^^^^^^^^^^^^^^^^
According to Smatch the only place where pdata->eq_cfgcnt get set is
from the assignment in max98095_i2c_probe() where we do:

	max98095->pdata = i2c->dev.platform_data;

I don't know how i2c->dev.platform_data gets set.  I would have thought
it would just be a zeroed buffer.

  1524                  if (strcmp(pdata->eq_cfg[i].name, max98095->eq_texts[sel]) == 0 &&
                                                                    ^^^^^^^^^^^^^
This is where the warning is generated.

  1525                          abs(pdata->eq_cfg[i].rate - fs) < best_val) {
  1526                          best = i;
  1527                          best_val = abs(pdata->eq_cfg[i].rate - fs);
  1528                  }
  1529          }

regards,
dan carpenter
