From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: Re: [PATCH] ASoC: Add support for NAU8824 codec to ASoC
Date: Thu, 26 Mar 2015 14:58:53 -0700
Message-ID: <5514811D.1060901@nuvoton.com>
References: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com> <20150224141314.GI6236@finisterre.sirena.org.uk> <54F6FC28.4030403@nuvoton.com> <20150304125527.GM21293@sirena.org.uk> <54F95721.7040103@nuvoton.com> <20150306210722.GK21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150306210722.GK21293@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>, ccchang12@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Sorry late to the response.

On 3/6/2015 1:07 PM, Mark Brown wrote:
> On Fri, Mar 06, 2015 at 03:28:33PM +0800, Chih-Chiang Chang wrote:
>
> Please fix your mailer to word wrap within paragraphs, it makes thing=
s a
> lot easier to read.
This seems to violate the kernel's rule. I am using the Thunderbird to
do upstream. And in kernel's documentation, it shows we should set
"mailnews.wraplength" from "72" to "0". Any way, for your convenience, =
I
already modify the "mailnews.wraplength" back to "72".
>
>> On 2015/3/4 =E4=B8=8B=E5=8D=88 08:55, Mark Brown wrote:
>>> On Wed, Mar 04, 2015 at 08:35:52PM +0800, Chih-Chiang Chang wrote:
>>>> On 2015/2/24 =E4=B8=8B=E5=8D=88 10:13, Mark Brown wrote:
>>> Add relevant control types if you need them, it's important to have
>>> proper stereo controls available to userspace.
>> We cannot find suitable macro in file "include\sound\soc.h", so we w=
ant to add below two macro for our chip.
>> SOC_DOUBLE_L_R_VALUE
>> SOC_DOUBLE_L_R_TLV
> Sounds good.
>
>>>>> This looks like you're reimplementing regmap's register sequence
>>>>> stuff...  It's also a *very* large sequence you have, are you sur=
e it's
>>>>> all required?  It seems like this may be doing a bunch of machine
>>>>> specific configuration but since it's all magic numbers it's hard=
 to
>>>>> tell.
>>>> Initial settings are arranged in order
>>> This doesn't answer or address my concern.
>> These large number of register setting is used to initial our codec,
>> and some of other codec have the same behavior. We will remove few
>> unnecessary register default setting and add some remark for
>> registers.
> I'd really like to have a better understanding of what this is doing =
-
> it can be valid to do this but there are some warning signs here such=
 as
> the volume of writes being large in comparison with the set of contro=
ls
> the driver exposes which mean I'd like to be sure the use matches
> expectations.  Normally this sort of thing is a small number of fixes
> for undocumented registers or updates to register defaults changed in
> later revisions of the chip.
We have tried to reduce the sequence recently, but it got some issues i=
n
the tests. We think these large number of register settings are
necessary to our NAU8824 codec. We will provide the comments of all
values in source to have a better understanding, is it acceptable to yo=
u?
>
>>> Don't include noise like this in upstream communication, if your co=
mpany
>>> won't fix this then please use an external mail account for upstrea=
m
>>> communication.
>> Our MIS report they have disabled to append message in mail. Hope yo=
u do not see it in this mail.
> It's gone, thanks.
