From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Subject: Re: [PATCH 01/16] ASoC: core: Add multi reg control
	struct & macros
Date: Wed, 21 Mar 2012 13:07:47 +0100
Message-ID: <4F69C493.7070109@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213859.GG3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog110.obsmtp.com (eu1sys200aog110.obsmtp.com
	[207.126.144.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FE024573
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 13:07:56 +0100 (CET)
In-Reply-To: <20120313213859.GG3177@opensource.wolfsonmicro.com>
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
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

I believe that the assumption that all the registers are contiguous would p=
ose a
troublesome limitation in this case.
We do have several controls that exposes signed 15-bit values that are mapp=
ed
across two 8-bit registers (16-bits in total) in a big-endian order.
While for those particular controls a contiguous (big endian) order like you
suggested would work just fine, we also have other controls with signed 32-=
bit
values that span four 8-bit registers that mapped in the following manner:

bits	31-24	23-16	15-8	7-0
reg	0x59	0x5A	0x59	0x5A

This means that to write one complete 32-bit value we would actually need to
write to the same 8-bit registers twice.

I originally considered to put in two more parameters to consolidate the fo=
ur
macros to one, one being no of registers and one specifying big- or
little-endian order. But as you can see unfortunately neither little or big
endian contiguous order would suffice in the case described above so theref=
ore I
opted to give the user full control in specifying the registers and what or=
der
they should map to the composite value when using the macro allowing for ev=
ery
possible combination which seems to be the most generic approach allowing f=
or
different formats.

Also I believe that the definition S1R,S2R,S4R together with S8R might in f=
act
already be a fairly complete set with no need to add some new crop of macro=
s for
this in future. Why? Well since the value handled by ASoC-framework when
setting/reading a integer control is of type long (snd_ctl_elem_value) in
combination with the fact that 1 byte being the smallest register size in
framework means that in a 64-bit world this would translate to a maximum of
eight registers mapping the composite value of that long value.
Actually in our driver we only need S1R, S2R and S4R. I added the S8R varia=
nt
just to provide a complete implementation covering up to the full 64 bit
(8*8-bit). So until we need to deal with 128-bit computers and someone would
need this exact type of composite control in 128-bit then I believe these f=
our
macros should suffice for most cases.

Anyhow in light of the situation above do you think we could stick to the
submitted approach or do you have some other suggestion on how to define the
signed 32-bit value control with registers mapped in the above described fa=
shion?


On 2012-03-13 22:39, Mark Brown wrote:

> On Tue, Mar 13, 2012 at 04:11:28PM +0100, Ola Lilja wrote:
> =

>> SOC_SINGLE_VALUE_S1R  One control value spans one register
>> SOC_SINGLE_VALUE_S2R  One control value spans two registers
>> SOC_SINGLE_VALUE_S4R  One control value spans four registers
>> SOC_SINGLE_VALUE_S8R  One control value spans eight registers
> =

> This is fairly painful; the number of registers really ought to be
> parameterised rather than having to add a new crop of macros every time
> there's a new format or a new count.  Can we possibly make the
> simplifying assumption that all the registers are contiguous?



-- =



*Kristoffer Karlsson*

Multimedia Platform Customization Lund

*ST-Ericsson*
Product Group Mobile Platforms

Scheelev=E4gen 19B
223 63, Lund
Sweden
www.stericsson.com <http://www.stericsson.com/>
	Office: +46 46 10 3938
Mobile: +46 72 206 5192
Fax: +46 10 715 89 88
Email: kristoffer.karlsson@stericsson.com
<mailto:kristoffer.karlsson@stericsson.com>


This communication is confidential and intended solely for the addressee(s)=
. Any
unauthorized review, use, disclosure or distribution is prohibited. If you
believe this message has been sent to you in error, please notify the sende=
r by
replying to this transmission and delete the message without disclosing it.
Thank you.

E-mail including attachments is susceptible to data corruption, interceptio=
n,
unauthorized amendment, tampering and viruses, and we only send and receive
emails on the basis that we are not liable for any such corruption,
interception, amendment, tampering or viruses or any consequences thereof.
