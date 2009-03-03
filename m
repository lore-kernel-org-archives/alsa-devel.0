From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Tue, 3 Mar 2009 11:33:18 +0800
Message-ID: <f17812d70903021933h5315722q88e41a6f821dfc85@mail.gmail.com>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
	<s5heixgi1fv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id CF074244C7
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 04:33:19 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2262191rvf.32
	for <alsa-devel@alsa-project.org>; Mon, 02 Mar 2009 19:33:18 -0800 (PST)
In-Reply-To: <s5heixgi1fv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 2, 2009 at 7:55 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 2 Mar 2009 11:25:46 +0800,
> Eric Miao wrote:
>>
>> Considering the fact that most cpu_dai or codec_dai are using a same
>> 'snd_soc_dai_ops' for several similar interfaces, 'ops' would be better
>> made a pointer instead, to make sharing easier and code a bit cleaner.
>>
>> The patch below is rather preliminary since the asoc tree is being
>> actively developed, and this touches almost every piece of code,
>> (and possibly many others in development need to be changed as
>> well). Building of all codecs are OK, yet to every SoC, I didn't test
>> that.
>>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>
> Don't forget to update Documentation/sound/alsa/soc/*, too.
> (I don't mind who does it, though ;)
>

Yes, I took a rough look into those files, and some of which are
already inconsistent with the existing code. E.g. 'dai_ops' looks
non-existent now, merged into '.ops' already. And other stories
I'm afraid I cann't tell much. So

Liam or Mark,

I'd prefer you guys make those descriptions more consistent if
possible?
