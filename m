From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC] bug in soc_pcm_open
Date: Tue, 12 Jun 2007 02:14:49 +0530
Message-ID: <8d6898730706111344x6a6f53e1n4a21d8b93da83f70@mail.gmail.com>
References: <loom.20070611T165936-889@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id C1C1B10381F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 22:44:54 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1270686nzf
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 13:44:53 -0700 (PDT)
In-Reply-To: <loom.20070611T165936-889@post.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Seems like a problem,
Adding to that

if (machine->ops && machine->ops->shutdown)
		machine->ops->shutdown(substream);

if (platform->pcm_ops->close)
		platform->pcm_ops->close(substream);

if (cpu_dai->ops.shutdown)
		cpu_dai->ops.shutdown(substream);

if it is a error condition then above functions are called twice (also
in snd_codec_close())

Nobin Mathew


On 6/11/07, Matthieu CASTET <matthieu.castet@parrot.com> wrote:
> Hi,
>
> it seems there is a bug in soc_pcm_open. In some case [1] we are in a error
> path, but we don't set the ret return value.
>
> This cause bug/crash from alsa core.
>
> Thanks
>
> Matthieu
>
>
>
> [1]http://hg-mirror.alsa-project.org/alsa-kernel/file/38926de0e79c/soc/soc-core.c
> if (!runtime->hw.rates) {
>
>      218               printk(KERN_ERR "asoc: %s <-> %s No matching rates\n",
>
>      219                       codec_dai->name, cpu_dai->name);
>
>      220               goto machine_err;
>
>      221       }
>
>      222       if (!runtime->hw.formats) {
>
>      223               printk(KERN_ERR "asoc: %s <-> %s No matching formats\n",
>
>      224                       codec_dai->name, cpu_dai->name);
>
>      225               goto machine_err;
>
>      226       }
>
>      227       if (!runtime->hw.channels_min || !runtime->hw.channels_max) {
>
>      228               printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",
>
>      229                       codec_dai->name, cpu_dai->name);
>
>      230               goto machine_err;
>
>      231       }
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
