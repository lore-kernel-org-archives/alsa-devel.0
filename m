From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Mon, 11 Jan 2010 09:11:19 -0600
Message-ID: <4B4B3F97.8060508@ridgerun.com>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DC7710380B
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 16:12:11 +0100 (CET)
In-Reply-To: <20100108193720.GA3088@sirena.org.uk>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jan 08, 2010 at 11:36:59AM -0600, Miguel Aguilar wrote:
>> Mark Brown wrote:
>>> On Thu, Jan 07, 2010 at 04:17:21PM -0600, miguel.aguilar@ridgerun.com wrote:
> 
>>>> +		if (device == 0)
>>>> +			davinci_cfg_reg(DM365_EVT2_ASP_TX);
>>>> +		else
>>>> +			davinci_cfg_reg(DM365_EVT2_VC_TX);
> 
>>> I'd be a bit more comfortable with this if it were using something more
>>> symbolic like a #define or enum rather than checking a bare number to
>>> work out which device it's talking to.
> 
>> The idea of these function is check at runtime if the user space application is 
>> requesting the AIC3x or the voice codec, then it will set the proper source for 
>> the dma channels, since the ASP and the Voice Codec share the same dma channels, 
>> so that's why use a #define doesn't make sense.
> 
> I see what your code is doing but at the minute it's making this
> decision based on the device number that's being passed in by comparing
> it as a pure number.  This seems fragile - something symbolic that
> joined things up a bit more wouldn't raise eyebrows in the same way.
> 
>> Can you check the part of this patch related to registering both codecs AIC3x 
>> and the voice codec?
> 
> Like I say that all looks fine to me but I can't really check if the
> DaVinci code is idiomatic.

Is there any way to tell alsamixer to use the controls of one subdevice or the 
other?
