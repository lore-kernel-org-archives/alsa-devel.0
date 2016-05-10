From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Tue, 10 May 2016 09:32:31 -0700
Message-ID: <CAG5mAdwS_MBK=AW2GxjhC5HTcwpvmHAJr0Dy5tpGGLsU1BRZ-Q@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A7bD7kAc1vz2eZqgqcV1WAEV+-D=UFw3ptQf43C7kROw@mail.gmail.com>
 <20160507231656.GA6348@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E529F2652EE
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:32:51 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id k142so24541853oib.1
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:32:51 -0700 (PDT)
In-Reply-To: <20160507231656.GA6348@Asurada>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 7, 2016 at 4:16 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Sat, May 07, 2016 at 07:56:41PM -0300, Fabio Estevam wrote:
>> Hi Nicolin,
>>
>> On Tue, May 3, 2016 at 9:13 AM, Arnaud Mouiche
>> <arnaud.mouiche@invoxia.com> wrote:
>>
>> > Arnaud Mouiche (6):
>> >   ASoC: fsl_ssi: Real hardware channels max number is 32
>> >   ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the
>> >     sysclk.
>> >   ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
>> >   ASoC: fsl_ssi: Fix samples being dropped at Playback startup
>> >   ASoC: fsl_ssi: Fix channel slipping in Playback at startup
>> >   ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart
>> >     in full duplex.
>>
>> Are you happy with this version?
>
> I think I've already acked at v3. But anyway,
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
