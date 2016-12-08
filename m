From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: topology: Only free TLV for volume
 mixers of a widget
Date: Thu, 8 Dec 2016 16:32:36 +0300
Message-ID: <20161208133236.GA10418@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E1A26747F
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 14:41:01 +0100 (CET)
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
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mengdong Lin,

The patch eea3dd4f1247: "ASoC: topology: Only free TLV for volume
mixers of a widget" from Nov 25, 2016, leads to the following static
checker warning:

	sound/soc/soc-topology.c:1566 soc_tplg_dapm_widget_create()
	error: uninitialized symbol 'kcontrol_type'.

sound/soc/soc-topology.c
  1440  static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
  1441          struct snd_soc_tplg_dapm_widget *w)
  1442  {
  1443          struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
  1444          struct snd_soc_dapm_widget template, *widget;
  1445          struct snd_soc_tplg_ctl_hdr *control_hdr;
  1446          struct snd_soc_card *card = tplg->comp->card;
  1447          unsigned int kcontrol_type;
                             ^^^^^^^^^^^^^
  1448          int ret = 0;
  1449  
  1450          if (strnlen(w->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
  1451                  SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
  1452                  return -EINVAL;
  1453          if (strnlen(w->sname, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
  1454                  SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
  1455                  return -EINVAL;
  1456  
  1457          dev_dbg(tplg->dev, "ASoC: creating DAPM widget %s id %d\n",
  1458                  w->name, w->id);
  1459  
  1460          memset(&template, 0, sizeof(template));
  1461  
  1462          /* map user to kernel widget ID */
  1463          template.id = get_widget_id(w->id);
  1464          if (template.id < 0)
  1465                  return template.id;
  1466  
  1467          template.name = kstrdup(w->name, GFP_KERNEL);
  1468          if (!template.name)
  1469                  return -ENOMEM;
  1470          template.sname = kstrdup(w->sname, GFP_KERNEL);
  1471          if (!template.sname) {
  1472                  ret = -ENOMEM;
  1473                  goto err;
  1474          }
  1475          template.reg = w->reg;
  1476          template.shift = w->shift;
  1477          template.mask = w->mask;
  1478          template.subseq = w->subseq;
  1479          template.on_val = w->invert ? 0 : 1;
  1480          template.off_val = w->invert ? 1 : 0;
  1481          template.ignore_suspend = w->ignore_suspend;
  1482          template.event_flags = w->event_flags;
  1483          template.dobj.index = tplg->index;
  1484  
  1485          tplg->pos +=
  1486                  (sizeof(struct snd_soc_tplg_dapm_widget) + w->priv.size);
  1487          if (w->num_kcontrols == 0) {
  1488                  template.num_kcontrols = 0;
  1489                  goto widget;

Assume we hit this goto.

  1490          }
  1491  
  1492          control_hdr = (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
  1493          dev_dbg(tplg->dev, "ASoC: template %s has %d controls of type %x\n",
  1494                  w->name, w->num_kcontrols, control_hdr->type);

[ snip ]

  1546  
  1547  widget:
  1548          ret = soc_tplg_widget_load(tplg, &template, w);
  1549          if (ret < 0)
  1550                  goto hdr_err;
  1551  
  1552          /* card dapm mutex is held by the core if we are loading topology
  1553           * data during sound card init. */
  1554          if (card->instantiated)
  1555                  widget = snd_soc_dapm_new_control(dapm, &template);
  1556          else
  1557                  widget = snd_soc_dapm_new_control_unlocked(dapm, &template);
  1558          if (widget == NULL) {
  1559                  dev_err(tplg->dev, "ASoC: failed to create widget %s controls\n",
  1560                          w->name);
  1561                  ret = -ENOMEM;
  1562                  goto hdr_err;
  1563          }
  1564  
  1565          widget->dobj.type = SND_SOC_DOBJ_WIDGET;
  1566          widget->dobj.widget.kcontrol_type = kcontrol_type;

Then it's not initialized here.  I don't know if this causes an issue
beyond the static checker warning.

  1567          widget->dobj.ops = tplg->ops;
  1568          widget->dobj.index = tplg->index;
  1569          kfree(template.sname);

regards,
dan carpenter
