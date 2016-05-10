From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 6/6] ASoC: fsl_ssi: Fix channel slipping
 on capture (or playback) restart in full duplex.
Date: Tue, 10 May 2016 09:34:42 -0700
Message-ID: <CAG5mAdxMb0QiP6dbt4K_m=D19-FHnnLZY0JwZK2pnfTZYMpv6g@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5BkQvUA3EJJzgqWeiLRMm_=7=Q0xcqKnip0vGUrKLg5uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 963D82652EE
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:35:02 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id v145so24595483oie.0
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:35:02 -0700 (PDT)
In-Reply-To: <CAOMZO5BkQvUA3EJJzgqWeiLRMm_=7=Q0xcqKnip0vGUrKLg5uw@mail.gmail.com>
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
> On Tue, May 3, 2016 at 9:14 AM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
>> Happened when the Playback (or Capture) is running continuously
>> and Capture (or Playback) is restarted (xrun, manual stop/start...)
>>
>> Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
>> pending samples from previous capture (or playback) session may still
>> be present. They must be erased to not introduce channel slipping.
>>
>> FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
>> They are not documented in IMX50 or IMX6 RM, despite they are
>> working as expected on IMX6SL and IMX6solo.
>>
>> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
