From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Thu, 17 Mar 2011 14:19:27 -0700
Message-ID: <4D827ADF.3020400@codeaurora.org>
References: <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com> <20110316175357.GB15605@opensource.wolfsonmicro.com> <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com> <20110316180828.GC15605@opensource.wolfsonmicro.com> <1300328500.9428.21.camel@vkoul-udesk3> <4D819551.7090901@codeaurora.org> <20110317115413.GA31411@opensource.wolfsonmicro.com> <AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com> <20110317182518.GI31411@opensource.wolfsonmicro.com> <AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com> <20110317201653.GL31411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110317201653.GL31411@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: pl bossart <bossart.nospam@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I can see us still needing something dynamic for things like tunneled
> audio streams where you're likely to have them being instantiated
> dynamically (with associated control), you'd want UCM to be able to work
> with this to tell the application about how these should be joined up to
> the rest of the system and so on.

My impression about UCM is that scenario rules are written based on
statically defined elements. How does it discover run-time instantiated
elements and know what to do about it?
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
