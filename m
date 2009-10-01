From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: A few fix patches for ASoC
Date: Thu, 1 Oct 2009 18:44:48 +0100
Message-ID: <BF53A021-5579-46B7-9041-4C4D99504D76@opensource.wolfsonmicro.com>
References: <s5hfxa3k327.wl%tiwai@suse.de>
	<20091001152442.GD29526@sirena.org.uk>
	<s5heipni11r.wl%tiwai@suse.de>
	(sfid-20091001_163101_922709_696787D2)
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00BF924561
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 19:44:59 +0200 (CEST)
In-Reply-To: <s5heipni11r.wl%tiwai@suse.de>
	(sfid-20091001_163101_922709_696787D2)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 1 Oct 2009, at 16:30, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 1 Oct 2009 16:24:43 +0100,
> Mark Brown wrote:
>>
>> On Thu, Oct 01, 2009 at 09:04:32AM +0200, Takashi Iwai wrote:
>>
>>> commit c877c25170e2655d519b29e91d6c91d5d1a72a6f
>>> Author: Takashi Iwai <tiwai@suse.de>
>>> Date:   Thu Oct 1 08:33:47 2009 +0200
>>>
>>>    ASoC: Fix dependency of CONFIG_SND_PXA2XX_SOC_IMOTE2
>>
>> Hrm.  This one applies to every board which doesn't use AC97 (some  
>> will
>> need SPI but it's the same deal for that).  It should probably also  
>> be a
>> dependency on the actual I2C controller driver rather than I2C in
>> general since the driver isn't going to do anything if the I2C device
>> isn't actually able to come up, though that'd prevent people doing
>> strange stuff like having the I2C bus driver modular and the audio  
>> built
>> in.
>
> Well, the problem is that it unconditionally selects WM8940, and
> wm8940.c can't be built without CONFIG_I2C (and doesn't make much
> sense right now).  I'd happily remove that I2C Kconfig dependency if
> you are going to fix wm8940 part.

Yes, I see the problem you're trying to fix. It's just that this way  
it's going to bite pretty much every board one way or another. If it's  
just the randconfig style builds then bodging it in the CODEC drivers  
is probably more complete but OTOH it would be better to do it in a  
way that also ensures that the machine drivers are usable when  
enabled. I'll have a look and see how much trouble it would be to do  
that.
