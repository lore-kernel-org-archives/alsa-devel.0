From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH v3] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Sun, 8 Oct 2017 23:29:45 -0700
Message-ID: <CABCoZhB+aT_m5nd9ejWdRphHQL=557+j9h1E5iBTxWExLet2yg@mail.gmail.com>
References: <1506660759-61727-1-git-send-email-yesanishhere@gmail.com>
 <20170929090938.7hiem3daebiaodqh@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 055ED266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 08:29:47 +0200 (CEST)
Received: by mail-ua0-f193.google.com with SMTP id l40so7634362uah.5
 for <alsa-devel@alsa-project.org>; Sun, 08 Oct 2017 23:29:47 -0700 (PDT)
In-Reply-To: <20170929090938.7hiem3daebiaodqh@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 29, 2017 at 2:09 AM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Sep 28, 2017 at 09:52:39PM -0700, yesanishhere@gmail.com wrote:
>> From: anish kumar <yesanishhere@gmail.com>
>>
>> Currently in codec to codec dai link if there are multiple
>> params defined then dapm can use created kcontrol to
>> decide which param to apply at runtime.
>>
>> However, in case there is only single param configuration
>> then there is no point in creating the kcontrol and also there
>> is no point in allocating memory for kcontrol.
>>
>> In the snd_soc_dapm_new_pcm function, there is memory
>> allocation happening for kcontrol which is later used
>> or not used based on num_param. It is better to not
>> allocate memory when there is only a single configuration.
>> This change is to remedy that anomaly.
>>
>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>> ---
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Charles, do you know if there is anything pending for this series
to be picked up for merge in mark's tree?
>
> Thanks,
> Charles
