From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Thu, 05 May 2016 21:46:10 +0200
Message-ID: <87h9ecp9tp.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
	<1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
	<20160503115159.GP6292@sirena.org.uk> <87y47roski.fsf@belgarion.home>
	<20160504090702.GV6292@sirena.org.uk> <87pot0pbnf.fsf@belgarion.home>
	<20160505191728.GK6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160505191728.GK6292@sirena.org.uk> (Mark Brown's message of
	"Thu, 5 May 2016 20:17:28 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, May 05, 2016 at 09:06:44PM +0200, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > I see that, I just don't know why that helps.
>> In order to have a clean split between former ac97 bus implementation and this
>> new one, I didn't want to include any former ac97 includes, excepting in
>> sound/ac97/compat.c.
>
> It's probably a good idea to articulate some of this in the commit log
> then!
Fair point, I'll improve that.

>> This transition will be easier if the new ac97 code is isolated as much as
>> possible from the former code while providing backward compatibility ... hence
>> this patch.
>
> It'd probably have been clearer to me if it were splitting out all the
> register definitions rather than just some of them.
Euh unless I'm missing something I have splitted out all the ac97 generic
registers AFAIK. The only remaining ones are chip specific which I didn't take
as they should be in codec specific code and not ac97 generic one.

Cheers.

-- 
Robert
