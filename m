From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 3/4] ASoC: codecs: tas5720: add TAS5722
 specific volume control
Date: Mon, 15 Jan 2018 08:50:09 -0600
Message-ID: <ada57df8-66c0-0692-9250-422ef37cce95@ti.com>
References: <20171211190157.12371-1-afd@ti.com>
 <20171211190157.12371-3-afd@ti.com> <20171212120121.GH16323@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 498B1267515
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:50:11 +0100 (CET)
In-Reply-To: <20171212120121.GH16323@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/12/2017 06:01 AM, Mark Brown wrote:
> On Mon, Dec 11, 2017 at 01:01:56PM -0600, Andrew F. Davis wrote:
> 
>> The TAS5722 supports modifying volume in 0.25dB steps (as opposed to 0.5dB
>> steps on the TAS5720). Introduce a custom mixer control that allows taking
>> advantage of this finer output volume granularity.
> 
> Don't do this, it's just making things more complicated.  Instead do
> what other drivers do and register different sets of controls depending
> on which part you're working with.  The normal thing is to have a big
> table for all the shared controls that are the same on all variants then
> register additional tables during probe with those that vary for the
> individul devices.
> 

That is what we are doing here, the reason for the custom mixer control
is that the controlled bits span two registers in a odd way that is not
supported by the standard handlers.

>>  static const struct snd_kcontrol_new tas5720_snd_controls[] = {
>>  	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
>> -		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, dac_tlv),
>> +		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, tas5720_dac_tlv),
>> +	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
>> +		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
> 
> As ever all volume controls should end in Volume (like the immediately
> adjacent control does).
> 

This was done so this table exactly matches the existing table. If you
would like me to change this then I can, and can do it for the other
table as well, up to you.
