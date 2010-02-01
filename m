From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
 <richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH] alsa: Add support for timberdale I2S block
Date: Mon, 01 Feb 2010 16:20:38 +0100
Message-ID: <4B66F146.2050201@mocean-labs.com>
References: <4AE59E01.9000802@mocean-labs.com>
	<20091026130931.GA18781@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.bearnet.nu (relay.bearnet.nu [80.252.223.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 639A62443D
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 16:20:49 +0100 (CET)
In-Reply-To: <20091026130931.GA18781@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Oct 26, 2009 at 02:02:57PM +0100, Richard R?jfors wrote:
>> This driver adds support for the I2S block of the timberdale FPGA.
>>
>> The timberdale is a FPGA found on intel development boards for
>> In-Vehicle Infotainment.
>>
>> The block has support for up to 8 I2S channels, can be clocked
>> from either the FPGA or the device side.
>>
>> This driver introduces support for this block, by exposing each
>> I2S channel as an ALSA PCM channel.
>>
>> Signed-off-by: Richard R?jfors <richard.rojfors@mocean-labs.com>
> 
> Without having investigated in any great detail I'd really expect this
> driver to be done within ASoC if it's producing generic I2S output.  If
> it's producing I2S out then presumably system designers will be able to
> attach whatever CODECs they desire and if those CODECs require any soft
> control then there will be a need to interoperate with CODEC drivers.

This thing produces raw I2S/captures raw I2S as you say. It's used to
connect to bluetooth chips and radio DSP:s. So there are no CODEC:s
involved. Does it make sense to do it within ASoC?

--Richard
