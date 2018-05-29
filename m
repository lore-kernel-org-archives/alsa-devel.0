From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: set cpu dai clk in
	hw_params
Date: Tue, 29 May 2018 22:31:01 +0200
Message-ID: <50d6ad20-3cc8-323f-f8d6-0cb0a8b95ae7@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-2-daniel@zonque.org>
 <20180529111632.GB23509@sirena.org.uk>
 <fd307a0e-483c-6e64-5017-ecdf98814b1d@zonque.org>
 <20180529113243.GD23509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A4E266F88
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 22:31:01 +0200 (CEST)
In-Reply-To: <20180529113243.GD23509@sirena.org.uk>
Content-Language: en-US
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 29, 2018 01:32 PM, Mark Brown wrote:
> On Tue, May 29, 2018 at 01:17:45PM +0200, Daniel Mack wrote:
>> On Tuesday, May 29, 2018 01:16 PM, Mark Brown wrote:
>>> On Mon, May 28, 2018 at 09:35:01PM +0200, Daniel Mack wrote:
> 
>>>> +		if (dai_props->cpu_dai.clk)
>>>> +			clk_set_rate(dai_props->cpu_dai.clk, mclk);
> 
>>> We're ignoring the return value here.
> 
>> On purpose actually. Not all clocks might be settable, and in that case,
>> this is a no-op. You think we should bail or warn?
> 
> If we need to set the rate and fail to set it then clearly we shouldn't
> just carry on ignoring the error.  You might want some more involved
> logic there around checking if it's actually a rate change before you
> error out, and possibly some logic to carry on with whatever the rate is
> and a reduced set of resulting sample rates.
> 

Fair enough. I'll add that error checking at least, that makes sense.


Thanks for the feedback!
Daniel
