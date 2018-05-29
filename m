From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: set cpu dai clk in
	hw_params
Date: Tue, 29 May 2018 13:17:45 +0200
Message-ID: <fd307a0e-483c-6e64-5017-ecdf98814b1d@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-2-daniel@zonque.org>
 <20180529111632.GB23509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id A471A267651
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 13:17:47 +0200 (CEST)
In-Reply-To: <20180529111632.GB23509@sirena.org.uk>
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

On Tuesday, May 29, 2018 01:16 PM, Mark Brown wrote:
> On Mon, May 28, 2018 at 09:35:01PM +0200, Daniel Mack wrote:
> 
>>   	if (mclk_fs) {
>>   		mclk = params_rate(params) * mclk_fs;
>> +
>> +		if (dai_props->cpu_dai.clk)
>> +			clk_set_rate(dai_props->cpu_dai.clk, mclk);
>> +
> 
> We're ignoring the return value here.
> 

On purpose actually. Not all clocks might be settable, and in that case, 
this is a no-op. You think we should bail or warn?
