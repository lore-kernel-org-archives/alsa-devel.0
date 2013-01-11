From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual
	switch controls
Date: Fri, 11 Jan 2013 13:56:17 +0100
Message-ID: <50F00BF1.6090702@metafoo.de>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
	<1357833977-3682-2-git-send-email-lars@metafoo.de>
	<20130111121912.GY20956@opensource.wolfsonmicro.com>
	<50F007DF.9000606@metafoo.de>
	<20130111124535.GZ20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20130111124535.GZ20956-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 01:45 PM, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 01:38:55PM +0100, Lars-Peter Clausen wrote:
>> On 01/11/2013 01:19 PM, Mark Brown wrote:
> 
>>> going to affect everything else in the path).  I'd expect to see
>>> something like this implemented by having a control that has a specified
>>> value forced in the register while the control is enabled (kind of the
>>> opposite of a supply).  This is a fairly common need for older parts
>>> though it's unusual to see it on a new device.
> 
>> I think I want the opposite of what you just described. I want to be able to
>> overwrite the control setting based on the power state.
> 
> Right, just a thinko though - you see the point though.
> 
>> In ASoC I modeled this by letting DAPM take care of mute controls. E.g. the
>> mute control gets disabled if there is an active path from the DAC through
>> the mixer to one of the outputs and gets disabled otherwise. This makes sure
>> that when the DAC is powered down (when there is no active path from the DAC
>> to any of the outputs) each mute control is also enabled. The virtual
>> switches now allow disable a path from the DAC to the mixer, which in turn
>> will cause DAPM to enable the mute control. This is similar to how the
>> virtual enums already work.
> 
> Virtual enums do actually end up routing, that's not what a mute control
> usually does.  You can do the above in the manner I suggested, just have
> the register forced to a particular value when the DAC is disabled.

Well, that's what the code does. The alternative is to implement more or
less in the driver. Have custom put/get callbacks for the controls, which
write to a shadow register, only if the DAC is enabled the shadow value gets
written to the real register. And listen to the DAC powerdown/powerup
events, when it is powered down enable all hw mutes, when it is enabled
restore the shadow register value. The virtual control more or less
implements it in a generic manner so it does not have to be implemented by
each driver which needs this on its own.

- Lars
