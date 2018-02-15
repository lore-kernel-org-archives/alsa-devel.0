From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: Re: [PATCH 3/3] ASoC: hdac_hdmi : Ensuring proper setting of output
 widget power state
Date: Thu, 15 Feb 2018 14:00:21 +0530
Message-ID: <a1e2e283-656b-59b3-fbc3-09851ebd16cd@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-3-git-send-email-abhijeet.kumar@intel.com>
 <20180214162044.GG12658@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180214162044.GG12658@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Wang YanQing <udknight@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2/14/2018 9:50 PM, Mark Brown wrote:
> On Tue, Jan 23, 2018 at 11:00:53PM +0530, abhijeet.kumar@intel.com wrote:
>> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>>
>> In usecases like hot plug-unplug DP panel or modeset during a playback,
>> sometimes we observe no audio after codec resets. During no audio
>> condition, we have noticed that the power state of the pin or the
>> connector is D3. Optimizing the way we set the power mitigates the
>> issue. With this changes the verb is sent to set the power state and
>> waits until actual state reaches target state. Thus ensuring power state
>> is set.
> This doesn't apply after the recent refactoring to move to components -
> can you please rebase on current code and resend?  I pulled Takashi's
> branch already, it's just this patch needs handling.

Please find the re-based patch here.
https://patchwork.kernel.org/patch/10220549/

Warm Regards,
Abhijeet
