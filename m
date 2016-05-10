From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 5/6] ASoC: fsl_ssi: Fix channel slipping
 in Playback at startup
Date: Tue, 10 May 2016 09:34:32 -0700
Message-ID: <CAG5mAdzCLnB07W2+n28ry9Ys8sMmdx6er_7oF+KCDboDtf388A@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-6-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5BbS6CJ_AsYjUSYouoZySdj39AR6kUQi=evHfjn7=wbvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 24CC2265FF5
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:34:52 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id x19so24612705oix.2
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:34:52 -0700 (PDT)
In-Reply-To: <CAOMZO5BbS6CJ_AsYjUSYouoZySdj39AR6kUQi=evHfjn7=wbvw@mail.gmail.com>
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
>> Previously, SCR.SSIEN and SCR.TE were enabled at once if no capture
>> stream was also running.
>> This may not give a chance for the DMA to write the first sample in
>> TX FIFO before the streaming starts on the PCM bus, inserting void
>> samples first.
>> Those void samples are then responsible for slipping the channels.
>>
>> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
