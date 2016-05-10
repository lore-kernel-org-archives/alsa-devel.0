From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 4/6] ASoC: fsl_ssi: Fix samples being
 dropped at Playback startup
Date: Tue, 10 May 2016 09:34:19 -0700
Message-ID: <CAG5mAdxiULOCfJwHint3p9cfVwKFA4W71rNtJmzU8sOERbFetQ@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-5-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5DSX5fDmwov-sQSvD721mQ9Xf0qjtg6nK3XPLtchGh=aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F6AA2661A4
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:34:39 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id x19so24602422oix.2
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:34:39 -0700 (PDT)
In-Reply-To: <CAOMZO5DSX5fDmwov-sQSvD721mQ9Xf0qjtg6nK3XPLtchGh=aw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2016 at 5:24 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, May 3, 2016 at 9:13 AM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
>> If the capture is already running while playback is started, it is highly
>> probable (>80% in a 8 channels scenario) that samples are lost between
>> the DMA and TX fifo.
>>
>> The reason is that SIER.TDMAE is set before STCR.TFEN0, leaving a time
>> window where the FIFO doesn't receive the samples written by the DMA.
>>
>> This particular case happened only if capture is already enabled as
>> SCR.SSIEN is already set at the playback startup instant.
>>
>> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
