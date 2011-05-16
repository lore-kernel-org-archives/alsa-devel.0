From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCHv2] ASoC: Fix wrong data type access in a
	few codec drivers
Date: Mon, 16 May 2011 14:43:20 +0100
Message-ID: <4DD129F8.2070306@ti.com>
References: <1305303412-31837-1-git-send-email-jhnikula@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA5AC@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 13831103834
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 15:43:25 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AA5AC@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 13/05/11 17:40, Stephen Warren wrote:
> Jarkko Nikula wrote at Friday, May 13, 2011 10:17 AM:
>> Commit fafd217 ("ASoC: Store a list of widgets in a DAPM mux/mixer
>> kcontrol")
>> changed the control private data type that is passed to snd_soc_cnew when
>> creating dapm mixer and mux controls. Commit did not update a few codec
>> drivers that are using their own put callbacks and thus are accessing a
>> wrong data type.
>>
>> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> v2:
>> - wm8994 and wm8995 needs to be changed too. Thanks to
>>   Stephen Warren <swarren@nvidia.com> for noticing.
>> - "Otherwise, on Tegra+WM8903, I repro'd the bug, and tested the fix, so:
>>   Tested-by: Stephen Warren <swarren@nvidia.com>"
> 
> This version looks good to me. I guess that means:
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> ... although I figure my Tested-by is probably enough.
> 
> Thanks for fixing my bugs!
> 

Acked-by: Liam Girdwood <lrg@ti.com>
