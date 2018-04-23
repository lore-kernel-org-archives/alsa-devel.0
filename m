From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH 1/3] ASoC: tas6424: Allow disabling auto
 diagnostics for faster power-on
Date: Mon, 23 Apr 2018 21:00:18 +0200
Message-ID: <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
 <20180423154411.GK19834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id D5DFB267659
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 21:00:26 +0200 (CEST)
In-Reply-To: <20180423154411.GK19834@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org



On 23/04/2018 17:44, Mark Brown wrote:
> On Fri, Apr 20, 2018 at 12:04:42PM +0200, Jean-Jacques Hiblot wrote:
>> The TAS6424 incorporates both DC-load and AC-load diagnostics which are
>> used to determine the status of the load. The DC diagnostics runs when any
>> channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
>> state.
>> The DC diagnostics are turned on by default but if a fast startup without
>> diagnostics is required the DC diagnostics can be bypassed by adding the
>> property "disable-auto-diagnostics".
> This is making me think we should be smarter here and either only run
> the diagnostics once during boot or provide a user control for the
> diagnostics.  It seems like something that is more of a runtime software
> decision than something that's fixed in hardware design, is there
> anything about the hardware design that'd make it impossible to run
> diagnostics?
I can't think of anything that would make it unusable.
This auto diagnostic is really useful in cars where wires can get 
disconnected or shorted to ground.
In quieter environment it may not be as useful, and a test at startup 
may be sufficient.
Diagnostics can also be triggered at will.
Do you think a sysfs interface would be better suited to disable the 
autodiag ?

Thanks for your comment on the series.

JJ

>
>> +	if (tas6424->no_auto_diags) {
>> +		/*
>> +		 * Disable DC auto-diagnostics to save time when channel leave
>> +		 * Hi-Z state
>> +		 */
>> +		ret = regmap_update_bits(tas6424->regmap,
>> +					 TAS6424_DC_DIAG_CTRL1,
>> +					  0xff, TAS6424_LDGBYPASS);
> This could just be exposed to userspace as a simple switch control
> couldn't it?  I do note that it masks more bits than it sets though...
