From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: blackfin: Fix missing break
Date: Thu, 14 Nov 2013 13:26:08 +0200
Message-ID: <5284B350.4040402@ti.com>
References: <1384359300-21219-1-git-send-email-tiwai@suse.de>	<20131113164715.GX878@sirena.org.uk>	<s5h7gccb5i7.wl%tiwai@suse.de>	<s5h61rwb5e5.wl%tiwai@suse.de>	<20131113184751.GB878@sirena.org.uk>	<s5hwqkbqzf6.wl%tiwai@suse.de>	<20131114100806.GC26614@sirena.org.uk>
 <s5hsiuz9s23.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B5C2261A1C
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 12:26:09 +0100 (CET)
In-Reply-To: <s5hsiuz9s23.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 11/14/2013 12:49 PM, Takashi Iwai wrote:
> At Thu, 14 Nov 2013 10:08:06 +0000,
> Mark Brown wrote:
>>
>> On Thu, Nov 14, 2013 at 07:18:21AM +0100, Takashi Iwai wrote:
>>> Mark Brown wrote:
>>
>>>> That looks to be an issue that's very specific to OMAP4 - you need
>>>> someone who works on OMAP4 to have a look at it.
>>
>>> OK, then could you assign to an appropriate person?
>>> You must have a better clue.
>>
>> Peter Ujfalusi at a guess.
> =

> Peter, could you care the bug report below?
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D64741

Sure.
Platforms using McPDM+twl6040 codec (OMAP4/5) supports 96KHz only at the mo=
ment.
This is hardware limitation and the only way to get 44.1/48 KHz supported is
to use AESS on these platforms. Unfortunately I only have AESS support out =
of
tree in my personal branch since it has dependency on Liam's out of tree
dynamic firmware set (which I'm rolling from kernel version to kernel versi=
on).
To use AESS one need to have the firmware as well which is again not upstre=
am
currently.
I only have 3.12-rc1 based version of AESS support, but I'm planning to have
one for 3.12 and also for 3.13-rc1 when it comes out.

-- =

P=E9ter
