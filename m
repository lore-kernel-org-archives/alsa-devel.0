From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add Harmony sound
	platform data type
Date: Fri, 21 Jan 2011 14:41:08 -0800
Message-ID: <AANLkTi=t0c4kCziPg=b0nqNRSw4od2U7__NwMu=dhW3Q@mail.gmail.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-1-git-send-email-swarren@nvidia.com>
	<1295556731-25165-3-git-send-email-swarren@nvidia.com>
	<AANLkTimx3Co9HjpBoB07G8YnQG8LAukxMqLdCMgDf1j+@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03109559DF@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 54E76243FB
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 23:41:11 +0100 (CET)
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com
	[172.24.198.88]) by smtp-out.google.com with ESMTP id p0LMfAJA009531
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 14:41:10 -0800
Received: from qyk8 (qyk8.prod.google.com [10.241.83.136])
	by wpaz24.hot.corp.google.com with ESMTP id p0LMc8JT025052
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 14:41:09 -0800
Received: by qyk8 with SMTP id 8so999116qyk.13
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 14:41:08 -0800 (PST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03109559DF@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 2:35 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Colin Cross wrote on Friday, January 21, 2011 11:43 AM:
>>
>> On Thu, Jan 20, 2011 at 12:52 PM, Stephen Warren wrote:
>> > =A0create mode 100644 arch/arm/mach-tegra/include/mach/harmony_audio.h
>>
>> Does this file really belong in mach-tegra if its for a driver that is in
>> a common directory (drivers/sound/soc)? =A0Putting it in include/linux w=
ould
>> solve all your tree-ordering problems.
>
> Colin,
>
> Re: The location I chose; I followed an existing example of another ASoC
> driver. Perhaps there is a more appropriate location, although the ASoC
> maintainers didn't point one out.
>
> I'm afraid I don't understand how moving the file would solve the
> dependency issues though:
>
> There's a change in sound/soc/... that needs this new file.
>
> There's a change in arch/arm/mach-tegra/... that needs this new file.
>
> Both those two changes would typically get checked into two separate git
> repositories.
>
> As far as I can tell, we could:
>
> a) Check the new file into both repositories, and git will hopefully just
> merge them together in the next merge window. Mark pointed out a long time
> ago that this is generally frowned upon though.
>
> b) Check the change into just one repository, e.g. ASoC since it's ready =
to
> accept the sound/soc/... changes that rely on it, and then have Tegra's
> for-next merge that (or merge linux-next after it's filtered up there,
> although I'm not sure if merging linux-next is workable with git?) (or
> merge directly from ASoC's for-2.6.39) and only then apply the arch/arm/t=
egra
> changes that rely on it. Mark pointed out a long time ago that such cross-
> subsystem merges are very rare, although it sounded like they do happen
> sometimes.
>
> c) Only check in the sound/soc/... changes, wait until they're in 2.6.39-=
rc1
> and hence can be picked up from there for Tegra's for-next, and then chec=
k in
> the Tegra changes that rely on it. This would delay the complete changes
> until 2.6.40:-(
>
> I'm still in the dark how this normally works; it seems like it must be
> pretty common to add a new driver to the driver repository, with that dri=
ver
> defining a new platform_data type, and also needing to add code to the
> architecture/chip repository to provide that platform_data, and hopefully
> have both those things go in in parallel, rather than being staged across
> two kernel releases.

Could the same platform_data patch go into both ASoC and Tegra?  It
would fall out in the merge, no matter who gets pulled first.  If we
go that route, whichever place you put the header, one of the trees
will have an include file that is in the other tree's directory.

I still think the header makes more sense in include/sound than
mach-tegra, but if the ASoC maintainers prefer it in mach-tegra,
consider the patch Acked-by: Colin Cross <ccross@android.com> for
inclusion in the ASoC tree.
