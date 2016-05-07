From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 3/6] ASoC: fsl_ssi: Save a dev reference
 for dev_err() purpose.
Date: Sat, 7 May 2016 19:54:42 -0300
Message-ID: <CAOMZO5DDn26G2z0bg3Qz7vqgsR5Z-3BOHS1-Z+TU3mG0-GMBkQ@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-4-git-send-email-arnaud.mouiche@invoxia.com>
 <572896DC.6080008@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id EE957260438
 for <alsa-devel@alsa-project.org>; Sun,  8 May 2016 00:54:43 +0200 (CEST)
Received: by mail-ig0-f169.google.com with SMTP id s8so67255365ign.0
 for <alsa-devel@alsa-project.org>; Sat, 07 May 2016 15:54:43 -0700 (PDT)
In-Reply-To: <572896DC.6080008@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2016 at 9:17 AM, Timur Tabi <timur@tabi.org> wrote:
> Arnaud Mouiche wrote:
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 1a9d0ad..695f041 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -262,6 +262,7 @@ struct fsl_ssi_private {
>>         struct fsl_ssi_dbg dbg_stats;
>>
>>         const struct fsl_ssi_soc_data *soc;
>> +       struct device *dev;
>>   };
>
>
> I don't see where this pointer is used.

It is used in patch 5/6.
