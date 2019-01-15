From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
Date: Tue, 15 Jan 2019 15:16:57 -0600
Message-ID: <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


>> Beyond the fact that the platform_name seems to be totally useless,
>> additional tests show that the patch ('ASoC: soc-core: defer card probe
>> until all component is added to list') adds a new restriction which
>> contradicts existing error checks.
>>
>> None of the Intel machine drivers set the dailink "cpu_name" field but use
>> the "cpu_dai_name" field instead. This was perfectly legit as documented by
>> the code at the end of soc_init_dai_link()
> This should be fixed by the patch
> "ASoC: core: Don't defer probe on optional, NULL components" which Mark
> already applied to his tree. See
> http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html

Ah yes, I missed this patch while I was debugging. Indeed this fixes the 
problem and my devices work again with Mark's for-next branch. Thanks 
Matthias!

>
> Maybe the defer card probe logic needs to be extended to also check if
> dai_link_name had already been registered (either cpu or cpu_dai_name
> needs to be set), not 100% sure which problem the defer card probe patch
> was trying to solve.
same here, I don't get why the deferred probe stuff only deals with one 
of the two options.
