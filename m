From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Use dev_name() for
	registering the irq
Date: Mon, 29 Dec 2014 23:24:15 -0200
Message-ID: <CAOMZO5Cjc+asAtU+ttBRacUWCd6O3iRKSzxWDACBB80MTvUEug@mail.gmail.com>
References: <1419890246-21985-1-git-send-email-festevam@gmail.com>
 <20141229235424.GA2870@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D8C126058F
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 02:24:19 +0100 (CET)
Received: by mail-la0-f47.google.com with SMTP id hz20so12190810lab.34
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:24:16 -0800 (PST)
In-Reply-To: <20141229235424.GA2870@Alpha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 29, 2014 at 9:54 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Mon, Dec 29, 2014 at 07:57:26PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> The 'name' array is currently stored inside the fsl_esai private structure only
>> for registering the interrupt name.
>>
>> This can be simplified by registering it with dev_name() instead.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> The name from dev_name() is a little different but doesn't matter.
> The code looks neater now. I think we may also apply similar ones
> to other drivers as well -- ASRC, SPDIF, etc. Would you like to
> send the patches? Otherwise, I can do this instead :)

Good point. Will send patches for asrc and spdif as well. Thanks
