From: Andy Robinson <ajr55555@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: HDA: Add a new model "asus" for
 Conexant 5066/205xx
Date: Thu, 27 Jan 2011 00:45:49 -0500
Message-ID: <AANLkTimX0fiGBJMZspMjNAck4v+vxHzhNi+dUwC444+e@mail.gmail.com>
References: <4D398008.8080707@canonical.com> <s5hzkqshpdm.wl%tiwai@suse.de>
	<4D3D6CB7.5070102@canonical.com> <s5hd3nm8nwg.wl%tiwai@suse.de>
	<4D4024FF.3040506@canonical.com>
	<AANLkTikz=2fsQQwjuUWxxMHJRW-E_uq5p5X6y060muYr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D1F21037EE
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 06:45:58 +0100 (CET)
Received: by gyg8 with SMTP id 8so541542gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:45:57 -0800 (PST)
In-Reply-To: <AANLkTikz=2fsQQwjuUWxxMHJRW-E_uq5p5X6y060muYr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Tested the backport on an Asus U50F... works fine!

On Wed, Jan 26, 2011 at 10:56 AM, Andy Robinson <ajr55555@gmail.com> wrote:
> Certainly, I should be able test it sometime later today. I'll let you
> know the results.
>
> I'm wondering how common this configuration is on Asus systems - that
> is, if the asus model should be the rule for Asus rather than the
> exception for a few specific ones. When I have some free time, maybe
> I'll delve into the alsa-info database to see what's been reported
> there. I suppose it could also be handled generically by checking to
> see if mics are on nodes 0x1a, 0x1b, 0x1c, 0x1d, and/or 0x23, and
> automatically selecting the correct automic logic based on that.
>
> On Wed, Jan 26, 2011 at 8:43 AM, David Henningsson
> <david.henningsson@canonical.com> wrote:
>> On 2011-01-24 13:52, Takashi Iwai wrote:
>>>
>>> At Mon, 24 Jan 2011 13:12:39 +0100,
>>> David Henningsson wrote:
>>>>
>>>> On 2011-01-22 17:31, Takashi Iwai wrote:
>>>>>
>>>>> At Fri, 21 Jan 2011 13:46:00 +0100,
>>>>> David Henningsson wrote:
>>>>>>
>>>>>> BugLink: http://bugs.launchpad.net/bugs/701271
>>>>>>
>>>>>> This new model, named "asus", is identical to the "hp_laptop" model,
>>>>>> except for the location of the internal mic, which is at pin 0x1a.
>>>>>> It is used for Asus K52JU and Lenovo G560.
>>>>>>
>>>>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>>>>
>>>>> Applied, but to topic/asoc branch, as these involve rewrites.
>>>>> Thanks.
>>>>
>>>> You mean the topic/hda branch, right?
>>>
>>> Argh, yes, of course...
>>>
>>>> Does this mean it'll not be in 2.6.38, and will it be if I provide a
>>>> backport for the second patch?
>>>
>>> Right.
>>
>> Ok, here's a backport, although untested since I don't have the hardware
>> here. Andy, would it be possible for you to test it for me?
>>
>> --
>> David Henningsson, Canonical Ltd.
>> http://launchpad.net/~diwic
>>
>
