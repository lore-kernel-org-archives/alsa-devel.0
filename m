From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Tue, 15 Nov 2011 16:56:46 +0000
Message-ID: <CAOZdJXXubFXg1RTJTB2h_Q4YSPpvuGwikcT1xXsDVadEd3RZAg@mail.gmail.com>
References: <1321372779-8692-1-git-send-email-alan.tull@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E93F103941
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 17:56:54 +0100 (CET)
In-Reply-To: <1321372779-8692-1-git-send-email-alan.tull@freescale.com>
Content-Language: en-US
Content-ID: <2DCCA9FD82216B4D894D5EEA292AC929@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tull Alan-R80115 <R80115@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 15, 2011 at 9:59 AM, Alan Tull <alan.tull@freescale.com> wrote:
> Previously, only one static struct for ops existed for all
> platform DMA drivers to share. =A0Half of the ops are shared
> functions and the other half are initialized to point directly
> to ops in the platform driver. =A0This creates problems where
> each time soc_new_pcm is called, the new platform driver's
> ops would overwrite a subset of the ops.
>
> This patch creates and populates a ops struct for each call
> to soc_pcm_new.
>
> Signed-off-by: Alan Tull <alan.tull@freescale.com>
> ---

Something is wrong.  When I apply this patch, I get this:

  CC      sound/soc/soc-core.o
/home/b04825/git/linux.34/sound/soc/soc-core.c: In function
'soc_cleanup_card_resources':
/home/b04825/git/linux.34/sound/soc/soc-core.c:1583:3: error:
incompatible type for argument 1 of 'kfree'
/home/b04825/git/linux.34/include/linux/slab.h:161:6: note: expected
'const void *' but argument is of type 'struct snd_pcm_ops'

	/* free the ops */
	for (i =3D 0; i < card->num_rtd; i++) {
		struct snd_soc_pcm_runtime *rtd =3D &card->rtd[i];
		kfree(rtd->ops);
	}

rtd->ops is not a pointer, so it can't be freed.  Also, this:

+	rtd->ops =3D soc_pcm_ops;

is a memcpy.  Why not just write to rtd->ops directly?

-- =

Timur Tabi
Linux kernel developer at Freescale
