From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: rename immap_86xx.h to fsl_guts.h,
	and add 85xx support
Date: Wed, 21 Jul 2010 19:28:07 -0500
Message-ID: <AANLkTimqWvRIlCT6ba_za_sYXIMKrend0m5_ysuvXAG1@mail.gmail.com>
References: <1279749902-13459-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C56D5103806
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 02:28:38 +0200 (CEST)
Received: by yxm8 with SMTP id 8so2266966yxm.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 17:28:37 -0700 (PDT)
In-Reply-To: <1279749902-13459-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 5:05 PM, Timur Tabi <timur@freescale.com> wrote:
> The immap_86xx.h header file only defines one data structure: the "global
> utilities" register set found on Freescale PowerPC SOCs. =A0Rename this f=
ile
> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GU=
TS"
> register set on 85xx chips.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Argh, I forgot to add the text to explain e500 vs. e600.

V2 coming.



-- =

Timur Tabi
Linux kernel developer at Freescale
