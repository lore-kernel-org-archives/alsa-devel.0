From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: davinci-mcasp: Only disable
	inactive serializer
Date: Tue, 27 Mar 2018 13:34:55 +0200
Message-ID: <CAC3a_SDgNjxGLZu72zuecJV7e=0STWH8fUafK1h-7jFdGpM-vw@mail.gmail.com>
References: <20180227145104.5868-1-vishalthanki@gmail.com>
 <20180227145104.5868-2-vishalthanki@gmail.com>
 <e74a7b15-8971-6f58-ba10-21f3f0546afc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f53.google.com (mail-pl0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D89EF267194
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 13:35:17 +0200 (CEST)
Received: by mail-pl0-f53.google.com with SMTP id v7-v6so170578plo.4
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 04:35:17 -0700 (PDT)
In-Reply-To: <e74a7b15-8971-6f58-ba10-21f3f0546afc@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, elfring@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Mar 5, 2018 at 1:42 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
>
> On 2018-02-27 16:51, Vishal Thanki wrote:
>> As a side effect of the following commit, the active TX
>> serializer may get disabled which may result in distorted
>> audio output.
>>
>> ASoC: davinci-mcasp: Add support for multichannel playback
>> (2952b27e2e463b28d5c0f04000f96b968137ca42)
>>
>> For example, if a 4 channel I2S playback with two TX serializers
>> is activated. Later on, if a recording of 2 channels, with only 1 RX
>> serializer is started, which will also disable one of the TX
>> serializer because max_active_serializers is only calculated for
>> RX (recording) stream. This patch fixes this issue.
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
>> Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>

Just a gentle reminder, can this patch be accepted for the next release?

Regards,
Vishal
