From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 4/5] ASoC: max98090: Remove unnecessary
	braces
Date: Mon, 25 Feb 2013 09:44:52 +0530
Message-ID: <CAK9yfHyQjf1vpCM+to-2Do=a6mG8oHcX5STUY=VWjBDUpxh+JQ@mail.gmail.com>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
 <1361187134-7525-4-git-send-email-sachin.kamat@linaro.org>
 <20130220165258.GK2726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 3020526260C
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 05:14:54 +0100 (CET)
Received: by mail-oa0-f44.google.com with SMTP id h1so2500662oag.3
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 20:14:53 -0800 (PST)
In-Reply-To: <20130220165258.GK2726@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On 20 February 2013 22:22, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Feb 18, 2013 at 05:02:13PM +0530, Sachin Kamat wrote:
>
>> -     if (val >= 1) {
>> -             if (w->reg == M98090_REG_MIC1_INPUT_LEVEL) {
>> +     if (val >= 1){
>
> Your coding style fixes shouldn't introduce new coding style issues

Sorry for the error on my part. I have fixed this in the updated version.

> and...
>
>> +             if (w->reg == M98090_REG_MIC1_INPUT_LEVEL)
>
> ...in cases where you're nesting with other if statements it's often
> clearer to have the braces consistently over all levels of the
> conditional.

Right. I have retained them in nested cases.
