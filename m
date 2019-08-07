From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: use set_get_data in
 process load
Date: Wed, 7 Aug 2019 13:09:57 -0700
Message-ID: <CAFQqKeXnSFUDG_72LGhxMD5aAU-DjnnPc9oqcrWBy_NfJNRQLg@mail.gmail.com>
References: <20190807145227.26216-1-pierre-louis.bossart@linux.intel.com>
 <07fe0e09-6984-76c9-da7c-a1992e7f7b64@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D570F800F3
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 22:10:09 +0200 (CEST)
Received: by mail-yb1-xb43.google.com with SMTP id b16so1295153ybq.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2019 13:10:09 -0700 (PDT)
In-Reply-To: <07fe0e09-6984-76c9-da7c-a1992e7f7b64@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, Linux-ALSA <alsa-devel@alsa-project.org>, Jaska Uimonen <jaska.uimonen@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 7, 2019 at 12:32 PM Cezary Rojewski <cezary.rojewski@intel.com>
wrote:

> On 2019-08-07 16:52, Pierre-Louis Bossart wrote:
> > From: Jaska Uimonen <jaska.uimonen@intel.com>
>
> >       process = kzalloc(ipc_size, GFP_KERNEL);
> > -     if (!process)
> > +     if (!process) {
> > +             kfree(wdata);
> >               return -ENOMEM;
> > +     }
> >
> >       /* configure iir IPC message */
> >       process->comp.hdr.size = ipc_size;
> > @@ -1835,7 +1890,9 @@ static int sof_process_load(struct
> snd_soc_component *scomp, int index,
> >       if (ret != 0) {
> >               dev_err(sdev->dev, "error: parse process.cfg tokens failed
> %d\n",
> >                       le32_to_cpu(private->size));
> > -             goto err;
> > +             kfree(wdata);
> > +             kfree(process);
> > +             return ret;
> >       }
> >
>
> > @@ -1886,10 +1916,36 @@ static int sof_process_load(struct
> snd_soc_component *scomp, int index,
> >
> >       ret = sof_ipc_tx_message(sdev->ipc, process->comp.hdr.cmd, process,
> >                                ipc_size, r, sizeof(*r));
> > -     if (ret >= 0)
> > +
> > +     if (ret < 0) {
> > +             dev_err(sdev->dev, "error: create process failed\n");
> > +             kfree(wdata);
> > +             kfree(process);
> >               return ret;
> > -err:
> > -     kfree(process);
> > +     }
> > +
> > +     /* we sent the data in single message so return */
> > +     if (ipc_data_size) {
> > +             kfree(wdata);
> > +             return ret;
> > +     }
> > +
> > +     /* send control data with large message supported method */
> > +     for (i = 0; i < widget->num_kcontrols; i++) {
> > +             wdata[i].control->readback_offset = 0;
> > +             ret = snd_sof_ipc_set_get_comp_data(sdev->ipc,
> wdata[i].control,
> > +                                                 wdata[i].ipc_cmd,
> > +                                                 wdata[i].ctrl_type,
> > +                                                 wdata[i].control->cmd,
> > +                                                 true);
> > +             if (ret != 0) {
> > +                     dev_err(sdev->dev, "error: send control failed\n");
> > +                     kfree(process);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     kfree(wdata);
> >       return ret;
> >   }
>
> On several occasions you've added individual error paths instead of a
> unified one. Personally I don't find it easier to read and understand
> function's flow at all.
>
> <ifs with goto err>
>
> err:
>         kfree(process);
>         kfree(wdata);
>         return ret;
>
> doesn't look that bad..

Thanks for pointing out. Perhaps, the error handling can be improved a
little. We can fix in v2.

Thanks,
Ranjani

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
