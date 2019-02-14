From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: samsung: i2s: Convert to single
 component with multiple DAIs
Date: Thu, 14 Feb 2019 13:29:22 +0300
Message-ID: <20190214102922.GA8816@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E0AF267482
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 11:29:38 +0100 (CET)
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
To: s.nawrocki@samsung.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Sylwester Nawrocki,

This is a semi-automatic email about new static checker warnings.

The patch a404b72d2bdd: "ASoC: samsung: i2s: Convert to single 
component with multiple DAIs" from Feb 7, 2019, leads to the 
following Smatch complaint:

    sound/soc/samsung/i2s.c:1352 samsung_i2s_probe()
    warn: variable dereferenced before check 'i2s_pdata' (see line 1336)

sound/soc/samsung/i2s.c
  1315  static int samsung_i2s_probe(struct platform_device *pdev)
  1316  {
  1317          struct i2s_dai *pri_dai, *sec_dai = NULL;
  1318          struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
  1319          struct resource *res;
  1320          u32 regs_base, quirks = 0, idma_addr = 0;
  1321          struct device_node *np = pdev->dev.of_node;
                                    ^^^^^^^^^^^^^^^^^^^^^^

  1322          const struct samsung_i2s_dai_data *i2s_dai_data;
  1323          int num_dais, ret;
  1324          struct samsung_i2s_priv *priv;
  1325  
  1326          if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
  1327                  i2s_dai_data = of_device_get_match_data(&pdev->dev);
  1328          else
  1329                  i2s_dai_data = (struct samsung_i2s_dai_data *)
  1330                                  platform_get_device_id(pdev)->driver_data;
  1331  
  1332          priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  1333          if (!priv)
  1334                  return -ENOMEM;
  1335  
  1336		quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
                                                     ^^^^^^^^^^^^^^^^^^^^^^

If "np" is NULL then we dereference "i2s_pdata".

  1337		quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
  1338	
  1339		num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
  1340		priv->pdev = pdev;
  1341	
  1342		ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
  1343		if (ret < 0)
  1344			return ret;
  1345	
  1346		pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
  1347	
  1348		spin_lock_init(&priv->spinlock);
  1349		pri_dai->lock = &priv->spinlock;
  1350	
  1351		if (!np) {
  1352			if (i2s_pdata == NULL) {
                            ^^^^^^^^^^^^^^^^^
But here "np" is NULL and we're checking if i2s_pdata is also NULL.

  1353				dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
  1354				return -EINVAL;

regards,
dan carpenter
