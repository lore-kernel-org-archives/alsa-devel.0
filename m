From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add Harmony sound
	platform data type
Date: Fri, 21 Jan 2011 10:43:26 -0800
Message-ID: <AANLkTimx3Co9HjpBoB07G8YnQG8LAukxMqLdCMgDf1j+@mail.gmail.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-1-git-send-email-swarren@nvidia.com>
	<1295556731-25165-3-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F5EB103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:43:35 +0100 (CET)
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com
	[172.25.149.7]) by smtp-out.google.com with ESMTP id p0LIhT5b014119
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 10:43:34 -0800
Received: from qwh6 (qwh6.prod.google.com [10.241.194.198])
	by hpaq7.eem.corp.google.com with ESMTP id p0LIhQen022773
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 10:43:27 -0800
Received: by qwh6 with SMTP id 6so2271915qwh.21
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 10:43:26 -0800 (PST)
In-Reply-To: <1295556731-25165-3-git-send-email-swarren@nvidia.com>
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 12:52 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> =A0arch/arm/mach-tegra/include/mach/harmony_audio.h | =A0 19 ++++++++++++=
+++++++
> =A01 files changed, 19 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-tegra/include/mach/harmony_audio.h
>
> diff --git a/arch/arm/mach-tegra/include/mach/harmony_audio.h b/arch/arm/=
mach-tegra/include/mach/harmony_audio.h
> new file mode 100644
> index 0000000..5c46391
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/harmony_audio.h
> @@ -0,0 +1,19 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/harmony_audio.h
> + *
> + * Copyright 2011 NVIDIA, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +struct harmony_audio_platform_data {
> + =A0 =A0 =A0 int gpio_spkr_en;
> +};
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Does this file really belong in mach-tegra if its for a driver that is
in a common directory (drivers/sound/soc)?  Putting it in
include/linux would solve all your tree-ordering problems.
