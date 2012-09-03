From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Fix compilation error due to leftover
 code
Date: Mon, 03 Sep 2012 11:56:21 +0300
Message-ID: <504470B5.20404@ti.com>
References: <1346335575-1592-1-git-send-email-peter.ujfalusi@ti.com> <20120830180219.GI4356@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120830180219.GI4356@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/30/2012 09:02 PM, Mark Brown wrote:
> On Thu, Aug 30, 2012 at 05:06:15PM +0300, Peter Ujfalusi wrote:
>> Part of commit (which patches sound/soc/omap/mcbsp.c file):
>> 8fef626 ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
>>
>> since the tree where it has been applied did not had the earlier pat=
ch:
>> d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration
>> which changed code around omap_mcbsp_6pin_src_mux().
>>
>> Because of the missing part from 8fef626 the sound/soc/omap/mcbsp.c =
does
>> not compile in linux-next.
>=20
> This makes little sense to me.  If the other patch is a dependency wh=
y
> not merge that dependency?  What does this mean at the code level?

Commit d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration

changed a line within omap_mcbsp_6pin_src_mux() function to fix an erro=
r which
prevents the mux configuration in 3.4, 3.5, 3.6 kernels.

Commit 8fef626 ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration =
code

should remove this function fir 3.7 and the mux configuration should be=
 done
in the board files or via DTS.

You have reported when you applied the McBSP DT series that commit 8fef=
626 had
conflict when you applied it. This was because I have created the serie=
s on on
a branch where the 6pin function was already fixed since I knew it is g=
oing to
be in 3.6 when the 3.7 merge will open.

> You're just talking about textual issues here, there's no semantic
> information about what any of this stuff does or how the changes rela=
te
> to each other at all.
>=20
>> When you applied 8fef626 you mentioned that it did not applied clean=
ly.
>> The reason was that the branch did not had commit d0db84e applied pr=
ior to the
>> series:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054=
668.html
>=20
>> Now I can not find the d0db84e commit in the asoc tree (not in for-3=
=2E6, for-3.7
>> and not in for-next branch) anymore.
>=20
> The above doesn't mean much to me.

So how can we resolve this?
Are you going to rebase or update your 3.7, for-next topic/omap branche=
s on
mainline so they will contain the mainline patch (d0db84e)?
Not sure if I mentioned it but I have created a branch (for you to take=
, or
observe):
git://gitorious.org/omap-audio/linux-audio.git peter/topic/for-mark/oma=
p-3.7

Here I have your topic/omap branch rebased on mainline and I have fixed=
 the
commit 8fef626 and added the missing chunk in order to avoid build fail=
ure.

A patch against your 3.7, for-next, topic/omap will not apply in linux-=
next
and a patch on top of linux-next would not apply in the asoc tree.

Please let me know how can I help to resolve this - I do not want 3.7-r=
c1 to
be broken when it comes out for OMAP audio.

Thank you,
P=E9ter
