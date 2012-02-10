From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 10 Feb 2012 17:09:35 +0100
Message-ID: <4F35413F.9000701@canonical.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 4EF472442A
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 17:09:35 +0100 (CET)
In-Reply-To: <20120210155003.GA11701@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02/10/2012 04:50 PM, Mark Brown wrote:
> On Fri, Feb 10, 2012 at 02:08:52PM +0100, David Henningsson wrote:
>> On 02/10/2012 11:55 AM, Takashi Iwai wrote:
>>> David Henningsson wrote:
>
>>>> I guess it could be easier to parse if we avoid spaces in names,
>>> Exactly, it was the reason.
>> Given that the normal desktop user does not usually look at these values
>> these days, I'd say being parser friendly weighs heavier than being
>> "normal English".
> Not all the world is desktop.

The normal end user of the embedded system does not look at those values 
either.

>>> OTOH, we can take an optional directional suffix, i.e.
>>> "[location] base [direction] [channel]", too.  For example, base can
>>> be "Video" or "Line", and direction can be "Out" or "In".
>
>>> I'd like to hear rather comments from others.
>
>> I think both naming schemes are good, and I'm not too worried about them
>> being too verbose. If we run into names being longer than the string
>> length we could back off and drop the location, I guess.
>
> It's a complete pain for actually working with them and doing
> development - it renders badly in UIs (think about alsamixer for
> example, or people looking at things on 80 column terminals) and isn't
> friendly to people typing things in.

So your suggestion was, to avoid "Front Headphone" and "Rear Headphone" 
because the names were too long, and instead have "Headphone" and 
"Headphone,index=1" and have "Front" and "Rear" read out of a TLV?

That will be worse for everyone, both those doing work with them, 
looking in alsamixer, etc.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
