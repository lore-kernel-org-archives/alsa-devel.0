From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [question] Sample rate IC followed by DAC
Date: Sat, 5 Nov 2016 07:17:07 +1100
Message-ID: <300f410b-60dc-608f-f551-26acd4e337a7@flatmax.org>
References: <5e9a9d77-4a01-b41c-32aa-130d76958bef@flatmax.org>
 <51ece116-aabb-21fa-b339-8a8bd95d6b52@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas02p.mx.bigpond.com (nschwmtas02p.mx.bigpond.com
 [61.9.189.140]) by alsa0.perex.cz (Postfix) with ESMTP id F0D8C2674C0
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 21:17:11 +0100 (CET)
In-Reply-To: <51ece116-aabb-21fa-b339-8a8bd95d6b52@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 04/11/16 22:31, Clemens Ladisch wrote:
> Matt Flax wrote:
>> I have a sample rate converter IC, which is followed by a DAC. This kind=
 of setup :
>>
>> SoC chip -> Sample rate conv. chip -> DAC chip
> What is the purpose of the converter?  What problem does it solve?
It has a lower noise floor then libsamplerate.
>
>> How do you construct a machine driver for this setup ?
> The original DAC driver will not work correctly, as far as sample rate
> settings are concerned.
Yes, I was expecting that. Tell me, even in the current ALSA version, is =

there any support for sample rate converter hardware chains ? Situations =

where we need to control standard codecs which a after sample rate =

converters.
>> Unfortunately the silicon only supports an older 3.14 kernel.
> You mean, you paid for _no support_?  And now are asking here instead?
> (Not that a newer kernel version would help ...)
It is the Nexell s5p6818 silicon, community only support at this point. =

Also I couldn't find any examples of sample rate converter hardware =

chains in linux/sound/soc ...
> Well, if your goal isn't a proper driver for upstream, just hack the
> existing DAC driver to access the other I=B2C device, when needed.
>
Sure, I can do this. I can't find any examples on operating a codec =

within a codec. Would I export all function symbols and do it that way ?
> Regards,
> Clemens
