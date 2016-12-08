From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [bug report] ASoC: topology: Only free TLV for
 volume mixers of a widget
Date: Fri, 9 Dec 2016 05:47:26 +0900
Message-ID: <63f94a18-faab-82b1-6081-2c1305fdbabc@sakamocchi.jp>
References: <20161208133236.GA10418@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 425A126751C
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 21:47:29 +0100 (CET)
In-Reply-To: <20161208133236.GA10418@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On Dec 8 2016 22:32, Dan Carpenter wrote:
> Hello Mengdong Lin,
>
> The patch eea3dd4f1247: "ASoC: topology: Only free TLV for volume
> mixers of a widget" from Nov 25, 2016, leads to the following static
> checker warning:
>
> 	sound/soc/soc-topology.c:1566 soc_tplg_dapm_widget_create()
> 	error: uninitialized symbol 'kcontrol_type'.
>
> sound/soc/soc-topology.c
>   1440  static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
>   1441          struct snd_soc_tplg_dapm_widget *w)
>   1442  {
>   1443          struct snd_soc_dapm_context *dapm =3D &tplg->comp->dapm;
>   1444          struct snd_soc_dapm_widget template, *widget;
>   1445          struct snd_soc_tplg_ctl_hdr *control_hdr;
>   1446          struct snd_soc_card *card =3D tplg->comp->card;
>   1447          unsigned int kcontrol_type;
>                              ^^^^^^^^^^^^^
>   1448          int ret =3D 0;
>   1449
>   1450          if (strnlen(w->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) =3D=
=3D
>   1451                  SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
>   1452                  return -EINVAL;
>   1453          if (strnlen(w->sname, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) =3D=
=3D
>   1454                  SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
>   1455                  return -EINVAL;
>   1456
>   1457          dev_dbg(tplg->dev, "ASoC: creating DAPM widget %s id %d\n=
",
>   1458                  w->name, w->id);
>   1459
>   1460          memset(&template, 0, sizeof(template));
>   1461
>   1462          /* map user to kernel widget ID */
>   1463          template.id =3D get_widget_id(w->id);
>   1464          if (template.id < 0)
>   1465                  return template.id;
>   1466
>   1467          template.name =3D kstrdup(w->name, GFP_KERNEL);
>   1468          if (!template.name)
>   1469                  return -ENOMEM;
>   1470          template.sname =3D kstrdup(w->sname, GFP_KERNEL);
>   1471          if (!template.sname) {
>   1472                  ret =3D -ENOMEM;
>   1473                  goto err;
>   1474          }
>   1475          template.reg =3D w->reg;
>   1476          template.shift =3D w->shift;
>   1477          template.mask =3D w->mask;
>   1478          template.subseq =3D w->subseq;
>   1479          template.on_val =3D w->invert ? 0 : 1;
>   1480          template.off_val =3D w->invert ? 1 : 0;
>   1481          template.ignore_suspend =3D w->ignore_suspend;
>   1482          template.event_flags =3D w->event_flags;
>   1483          template.dobj.index =3D tplg->index;
>   1484
>   1485          tplg->pos +=3D
>   1486                  (sizeof(struct snd_soc_tplg_dapm_widget) + w->pri=
v.size);
>   1487          if (w->num_kcontrols =3D=3D 0) {
>   1488                  template.num_kcontrols =3D 0;
>   1489                  goto widget;
>
> Assume we hit this goto.
>
>   1490          }
>   1491
>   1492          control_hdr =3D (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
>   1493          dev_dbg(tplg->dev, "ASoC: template %s has %d controls of =
type %x\n",
>   1494                  w->name, w->num_kcontrols, control_hdr->type);
>
> [ snip ]
>
>   1546
>   1547  widget:
>   1548          ret =3D soc_tplg_widget_load(tplg, &template, w);
>   1549          if (ret < 0)
>   1550                  goto hdr_err;
>   1551
>   1552          /* card dapm mutex is held by the core if we are loading =
topology
>   1553           * data during sound card init. */
>   1554          if (card->instantiated)
>   1555                  widget =3D snd_soc_dapm_new_control(dapm, &templa=
te);
>   1556          else
>   1557                  widget =3D snd_soc_dapm_new_control_unlocked(dapm=
, &template);
>   1558          if (widget =3D=3D NULL) {
>   1559                  dev_err(tplg->dev, "ASoC: failed to create widget=
 %s controls\n",
>   1560                          w->name);
>   1561                  ret =3D -ENOMEM;
>   1562                  goto hdr_err;
>   1563          }
>   1564
>   1565          widget->dobj.type =3D SND_SOC_DOBJ_WIDGET;
>   1566          widget->dobj.widget.kcontrol_type =3D kcontrol_type;
>
> Then it's not initialized here.  I don't know if this causes an issue
> beyond the static checker warning.
>
>   1567          widget->dobj.ops =3D tplg->ops;
>   1568          widget->dobj.index =3D tplg->index;
>   1569          kfree(template.sname);

Sparse generates below warnings, as well.

sound/soc/soc-topology.c:2134:60: warning: Using plain integer as NULL =

pointer
sound/soc/soc-topology.c: In function =91soc_tplg_dapm_widget_create=92:
/home/mocchi/asoc/sound/soc/soc-topology.c:1566:36: warning: =

=91kcontrol_type=92 may be used uninitialized in this function =

[-Wmaybe-uninitialized]
   widget->dobj.widget.kcontrol_type =3D kcontrol_type;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~

I guess that one of 'SND_SOC_TPLG_TYPE_xxx' macro should be assigned to =

the variable, while the macro set has no apparent initial value. I have =

no idea to fix this issue. If were this related to =

'snd_ctl_elem_type_t', SNDRV_CTL_ELEM_TYPE_NONE could be available...


Regards

Takashi Sakamoto
