From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 4/7] sound: core: Avoid using timespec
	for struct snd_rawmidi_status
Date: Thu, 21 Sep 2017 14:56:48 +0200
Message-ID: <CAK8P3a1iiJfdodP0kLCOb4GTMPw-5DEciLAdMCMh5SPhTJLyeg@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org>
 <d4a0a3d89148f8fb0680c8846879039d71c2da02.1505973912.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id EC679266819
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 14:56:49 +0200 (CEST)
Received: by mail-io0-f195.google.com with SMTP id 93so5271033iol.4
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 05:56:49 -0700 (PDT)
In-Reply-To: <d4a0a3d89148f8fb0680c8846879039d71c2da02.1505973912.git.baolin.wang@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: fabf@skynet.be, Arvind Yadav <arvind.yadav.cs@gmail.com>, dharageswari.r@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, Takashi Iwai <tiwai@suse.com>, guneshwor.o.singh@intel.com, Liam Girdwood <lgirdwood@gmail.com>, SF Markus Elfring <elfring@users.sourceforge.net>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, jeeja.kp@intel.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Deepa Dinamani <deepa.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> -       case SNDRV_RAWMIDI_IOCTL_STATUS:
> +#if __BITS_PER_LONG == 32
> +       case SNDRV_RAWMIDI_IOCTL_STATUS32:
> +       {
> +               int err = 0;
> +               struct snd_rawmidi_status32 __user *status = argp;
> +               struct snd_rawmidi_status32 status32;
> +               struct snd_rawmidi_status64 status64;
> +
> +               if (copy_from_user(&status32, argp,
> +                                  sizeof(struct snd_rawmidi_status32)))
> +                       return -EFAULT;
> +               switch (status32.stream) {
> +               case SNDRV_RAWMIDI_STREAM_OUTPUT:
> +                       if (rfile->output == NULL)
> +                               return -EINVAL;
> +                       err = snd_rawmidi_output_status(rfile->output, &status64);
> +                       break;
> +               case SNDRV_RAWMIDI_STREAM_INPUT:
> +                       if (rfile->input == NULL)
> +                               return -EINVAL;
> +                       err = snd_rawmidi_input_status(rfile->input, &status64);
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               if (err < 0)
> +                       return err;
> +
> +               if (put_user(status64.stream, &status->stream) ||
> +                   put_user(status64.tstamp.tv_sec, &status->tstamp.tv_sec) ||
> +                   put_user(status64.tstamp.tv_nsec, &status->tstamp.tv_nsec) ||
> +                   put_user(status64.avail, &status->avail) ||
> +                   put_user(status64.xruns, &status->xruns))
> +                       return -EFAULT;
> +               return 0;
> +       }

This follows the existing coding style for the other functions, but I think
it would be nicer to express the last part as

       status32 = (struct snd_rawmidi_status32) {
               .stream = status->stream,
               .tstamp.tv_sec, &status->tstamp.tv_sec,
               .tstamp.tv_nsec, &status->tstamp.tv_nsec,
               .avail, &status->avail,
               .xruns, &status->xruns,
       };
       if (copy_to_user(status, &status32, sizeof(*status))
              return -EFAULT;
       return 0;

It's completely equivalent, I just find my version easier to read, and
it should produce slightly better object code.

Maybe the maintainers have a preference, or there might be
a good reason to use the series of put_user() instead.

       Arnd
