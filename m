From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Fri, 13 Mar 2015 11:17:23 +0800
Message-ID: <550256C3.6050005@linux.intel.com>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
 <20150311125047.GD28806@sirena.org.uk> <5500E346.8020700@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D701059B20@RTITMBSV03.realtek.com.tw>
 <550189CF.6020304@linux.intel.com> <20150312180148.GT28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 173FF260415
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 04:17:27 +0100 (CET)
In-Reply-To: <20150312180148.GT28806@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "subhransu.s.prusty@intel.com" <subhransu.s.prusty@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Sorry for forgetting to mention the patch dependency information in
previous mail.

Now since all the dependency rt5670 patches have been merged in for-next
branch, I just want to know what we need to do for next step to let
following patches be applied?

ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
ASoC: Intel: move the jack creation to Braswell machine drive

Thanks
Jin Yao

On 2015/3/13 2:01, Mark Brown wrote:
> On Thu, Mar 12, 2015 at 08:42:55PM +0800, Jin, Yao wrote:
> 
>> I pull the for-next branch right now and I can see the following rt5670
>> patches have been integrated.
> 
>> 66454b3 ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
>> cc3c340 ASoC: rt5670: export jack suspend/resume APIs
>> d3ef705 ASoC: rt5670: Add IRQ function
> 
>> Then I build the for-next branch with my patches (reverted before):
> 
>> ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
>> ASoC: Intel: move the jack creation to Braswell machine driver
> 
>> The build is successful. So it looks we don't need to resend the patch
>> series, just re-applying my patches should be OK.
> 
> These are two separate branches, if there's dependencies between the two
> branches we need to merge them before applying new patches - I think
> that's the missing piece of information here.
> 
