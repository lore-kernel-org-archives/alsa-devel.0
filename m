From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: wm97xx touch does not work after ac97 delayed dev
	reg removal
Date: Mon, 19 Jan 2015 19:58:22 +0100
Message-ID: <54BD53CE.4050306@metafoo.de>
References: <CAOLZvyE3tEec4QpdeYrJwNJEjcf18zodjF1XtQjzaeRdHA32wg@mail.gmail.com>
 <54BD4CDA.50309@metafoo.de>
 <CAOLZvyFHAoQauzA3gyUZkwH+dxsW6vov9j9ukhzx4QJ4U+7eZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-176.synserver.de
 [212.40.185.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 97A9A26145E
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 19:56:27 +0100 (CET)
In-Reply-To: <CAOLZvyFHAoQauzA3gyUZkwH+dxsW6vov9j9ukhzx4QJ4U+7eZQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/19/2015 07:42 PM, Manuel Lauss wrote:
> On Mon, Jan 19, 2015 at 7:28 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 01/19/2015 04:46 PM, Manuel Lauss wrote:
>>>
>>> Hi Lars,
>>>
>>> Since commit 6794f709b7124ff1e574c4f4c9494418ab56c4b4
>>> (ASoC: ac97: Drop delayed device registration) the wm9712 ts on
>>> my MIPS DB1300 board doesn't work any more:
>>>
>>> wm97xx-ts 0-0:wm9712-codec.1: Device with vendor 0000 is not a wm97xx
>>> db1200-ac97 db1300-ac97.0: wm9712-hifi <-> au1xpsc_ac97.1 mapping ok
>>> wm9712-codec wm9712-codec.1: ASoC: mux Differential Source has no paths
>>> wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone Mux has no paths
>>> db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2 mapping ok
>>>
>>> whereas before this patch:
>>> [    1.820000] db1200-ac97 db1300-ac97.0: wm9712-hifi <->
>>> au1xpsc_ac97.1 mapping ok
>>> [    1.820000] wm9712-codec wm9712-codec.1: ASoC: mux Differential
>>> Source has no paths
>>> [    1.830000] wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone
>>> Mux has no paths
>>> [    1.840000] wm97xx-ts 0-0:wm9712-codec.1: detected a wm9712 codec
>>> [    1.850000] input: wm97xx touchscreen as
>>> /devices/platform/db1300-ac97.0/0-0:wm9712-codec.1/input/input0
>>> [    1.860000] db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2
>>> mapping ok
>>>
>>>
>>> Do you have any ideas how to solve this?
>>
>>
>> For a proper fix probably rewrite the AC97 bus support. But can you try if
>> the attached patch works as a workaround?
>
> Yes it does.

Ok, thanks for testing. I'll try to put together a proper patch and then send 
it out tomorrow or so. The wm9705 and wm9713 look like they need the same 
patch. So maybe it is possible to add support for reseting the device in the 
core itself rather than doing it for every device in the device driver.

- Lars
