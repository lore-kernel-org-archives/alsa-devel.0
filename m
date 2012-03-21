From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 11:46:12 +0200
Message-ID: <4F69A364.6050206@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com> <4F698B56.6030502@ti.com>
	<4F69920B.4010701@bitmer.com>
	<20120321084051.GA9342@opensource.wolfsonmicro.com>
	<4F699C5E.6070905@ti.com> <4F69A08B.5080100@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 796E724335
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 10:46:30 +0100 (CET)
Received: by lahi5 with SMTP id i5so652996lah.25
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 02:46:15 -0700 (PDT)
In-Reply-To: <4F69A08B.5080100@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2012 11:34 AM, Jarkko Nikula wrote:
> On 03/21/2012 11:16 AM, Peter Ujfalusi wrote:
>> Agreed. Let's drop this patch, and try to figure out something which can
>> be used by other platforms as well.
>>
>> I would keep the first two patch in this series..
>>
> I acked already 1/3 but 2/3 needs commit log update and change below
> looks suspicious for omap1 and 2.

True, I'll update the commit log for patch 2.

> @@ -120,6 +120,9 @@ static int omap_mcbsp_dai_startup(struct
> snd_pcm_substream *substream,
>  	if (!cpu_dai->active)
>  		err =3D omap_mcbsp_request(mcbsp);
> =

> +	if (!mcbsp->pdata->buffer_size)
> +		return err;

We only need to set the constraints on OMAP versions which have FIFO. If
buffer_size is 0 we can just return without going forward.
It removes one level of nested code in the function.

-- =

P=E9ter
