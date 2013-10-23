From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [PATCH RESEND] ASoC: dont call dapm_sync while
 reporting jack always
Date: Tue, 22 Oct 2013 19:45:50 -0700
Message-ID: <5267385E.6020007@codeaurora.org>
References: <1382362654-26213-1-git-send-email-vinod.koul@intel.com>
 <20131022083223.GA20821@sirena.org.uk> <20131022153654.GQ14013@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 30B5726082D
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2013 04:45:58 +0200 (CEST)
In-Reply-To: <20131022153654.GQ14013@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/22/2013 8:36 AM, Vinod Koul wrote:
> On Tue, Oct 22, 2013 at 09:32:23AM +0100, Mark Brown wrote:
>> On Mon, Oct 21, 2013 at 07:07:34PM +0530, Vinod Koul wrote:
>>> While reporting the jack status snd_soc_jack_report() invokes snd_soc_dapm_sync()
>>> always. This should be required when we have pins associated with jack and
>>> reporting enables or disables these.
>>> So add a check for this case
>>
>> Applied, thanks.  It'd be good when doing things like this to say what
>> the advantage is; with DAPM the general thing is that it gets called a
>> lot so it should be cheap enough to just call all the time.
> Okay, my thoughts were that it was obvious. We saw an issue when monkey testing
> with jack, bunch of dapm_sync's got triggered (insertion, reroute from usermode,
> removal, again reroute from usermode, and so on). The insertion and removal ones
> were quite not required for cases with no pins
>
We observed the same thing on our side and create another report API
which does not call snd_soc_dapm_sync() :)
Thanks for working out a better solution

Thanks
Patrick
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
