From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [bug report] ALSA: usb: add UAC3 BADD profiles
	support
Date: Wed, 16 May 2018 14:36:54 +0300
Message-ID: <CAB=otbR2Cw4mhMj_XTWGRY9fHFdRDva78JTwVoeNH0p_g6dnVA@mail.gmail.com>
References: <20180516113253.GA29128@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E25E7266F44
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 13:36:55 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so803078wmg.0
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 04:36:55 -0700 (PDT)
In-Reply-To: <20180516113253.GA29128@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On Wed, May 16, 2018 at 2:32 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> [ Your patch didn't really introduce the bug, it just made it visible
>   to static checkers.  - dan ]
>
> Hello Ruslan Bilovol,
>
> The patch 17156f23e93c: "ALSA: usb: add UAC3 BADD profiles support"
> from May 4, 2018, leads to the following static checker warning:
>
>         sound/usb/stream.c:984 snd_usb_get_audioformat_uac3()
>         warn: possible memory leak of 'chmap'
>
> sound/usb/stream.c
>    864
>    865                  chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
>    866                  if (!chmap)
>    867                          return ERR_PTR(-ENOMEM);
>    868
>    869                  if (num_channels == 1) {
>    870                          chmap->map[0] = SNDRV_CHMAP_MONO;
>    871                  } else {
>    872                          chmap->map[0] = SNDRV_CHMAP_FL;
>    873                          chmap->map[1] = SNDRV_CHMAP_FR;
>    874                  }
>    875
>    876                  chmap->channels = num_channels;
>    877                  clock = UAC3_BADD_CS_ID9;
>    878                  goto found_clock;
>    879          }
>    880
>    881          as = snd_usb_find_csint_desc(alts->extra, alts->extralen,
>    882                                       NULL, UAC_AS_GENERAL);
>    883          if (!as) {
>    884                  dev_err(&dev->dev,
>    885                          "%u:%d : UAC_AS_GENERAL descriptor not found\n",
>    886                          iface_no, altno);
>    887                  return NULL;
>    888          }
>    889
>    890          if (as->bLength < sizeof(*as)) {
>    891                  dev_err(&dev->dev,
>    892                          "%u:%d : invalid UAC_AS_GENERAL desc\n",
>    893                          iface_no, altno);
>    894                  return NULL;
>    895          }
>    896
>    897          cluster_id = le16_to_cpu(as->wClusterDescrID);
>    898          if (!cluster_id) {
>    899                  dev_err(&dev->dev,
>    900                          "%u:%d : no cluster descriptor\n",
>    901                          iface_no, altno);
>    902                  return NULL;
>    903          }
>    904
>    905          /*
>    906           * Get number of channels and channel map through
>    907           * High Capability Cluster Descriptor
>    908           *
>    909           * First step: get High Capability header and
>    910           * read size of Cluster Descriptor
>    911           */
>    912          err = snd_usb_ctl_msg(chip->dev,
>    913                          usb_rcvctrlpipe(chip->dev, 0),
>    914                          UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
>    915                          USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
>    916                          cluster_id,
>    917                          snd_usb_ctrl_intf(chip),
>    918                          &hc_header, sizeof(hc_header));
>    919          if (err < 0)
>    920                  return ERR_PTR(err);
>    921          else if (err != sizeof(hc_header)) {
>    922                  dev_err(&dev->dev,
>    923                          "%u:%d : can't get High Capability descriptor\n",
>    924                          iface_no, altno);
>    925                  return ERR_PTR(-EIO);
>    926          }
>    927
>    928          /*
>    929           * Second step: allocate needed amount of memory
>    930           * and request Cluster Descriptor
>    931           */
>    932          wLength = le16_to_cpu(hc_header.wLength);
>    933          cluster = kzalloc(wLength, GFP_KERNEL);
>    934          if (!cluster)
>    935                  return ERR_PTR(-ENOMEM);
>    936          err = snd_usb_ctl_msg(chip->dev,
>    937                          usb_rcvctrlpipe(chip->dev, 0),
>    938                          UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
>    939                          USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
>    940                          cluster_id,
>    941                          snd_usb_ctrl_intf(chip),
>    942                          cluster, wLength);
>    943          if (err < 0) {
>    944                  kfree(cluster);
>    945                  return ERR_PTR(err);
>    946          } else if (err != wLength) {
>    947                  dev_err(&dev->dev,
>    948                          "%u:%d : can't get Cluster Descriptor\n",
>    949                          iface_no, altno);
>    950                  kfree(cluster);
>    951                  return ERR_PTR(-EIO);
>    952          }
>    953
>    954          num_channels = cluster->bNrChannels;
>    955          chmap = convert_chmap_v3(cluster);
>    956          kfree(cluster);
>    957
>    958          /*
>    959           * lookup the terminal associated to this interface
>    960           * to extract the clock
>    961           */
>    962          input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
>    963                                                              as->bTerminalLink);
>    964          if (input_term) {
>    965                  clock = input_term->bCSourceID;
>    966                  goto found_clock;
>    967          }
>    968
>    969          output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
>    970                                                               as->bTerminalLink);
>    971          if (output_term) {
>    972                  clock = output_term->bCSourceID;
>    973                  goto found_clock;
>    974          }
>    975
>    976          dev_err(&dev->dev, "%u:%d : bogus bTerminalLink %d\n",
>    977                          iface_no, altno, as->bTerminalLink);
>    978          return NULL;
>    979
>    980  found_clock:
>    981          fp = audio_format_alloc_init(chip, alts, UAC_VERSION_3, iface_no,
>    982                                       altset_idx, altno, num_channels, clock);
>    983          if (!fp)
>    984                  return ERR_PTR(-ENOMEM);
>
> We should free "chmap" before returning.
>
>    985
>    986          fp->chmap = chmap;
>    987
>    988          if (badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
>    989                  fp->attributes = 0; /* No attributes */
>    990
>    991                  fp->fmt_type = UAC_FORMAT_TYPE_I;
>    992                  fp->formats = badd_formats;
>    993
>    994                  fp->nr_rates = 0;       /* SNDRV_PCM_RATE_CONTINUOUS */
>    995                  fp->rate_min = UAC3_BADD_SAMPLING_RATE;
>    996                  fp->rate_max = UAC3_BADD_SAMPLING_RATE;
>    997                  fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
>    998
>    999          } else {
>   1000                  fp->attributes = parse_uac_endpoint_attributes(chip, alts,
>   1001                                                                 UAC_VERSION_3,
>   1002                                                                 iface_no);
>   1003                  /* ok, let's parse further... */
>   1004                  if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
>   1005                          kfree(fp->rate_table);
>   1006                          kfree(fp);
>   1007                          return NULL;
>
> And here as well?  I don't know.

Correct, this was not obvious before UAC3 refactoring, but now the
issue is clear.
I'll send a fix soon.

Thanks,
Ruslan
