From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 11:49:06 -0300
Message-ID: <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E55CE2604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 16:49:07 +0200 (CEST)
Received: by mail-io0-f177.google.com with SMTP id 190so142879687iow.1
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 07:49:07 -0700 (PDT)
In-Reply-To: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brain@jikos.cz
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 30, 2016 at 8:18 AM, Petr Kulhavy <brain@jikos.cz> wrote:
> Hi,
>
> I'm trying to run the latest mainline kernel 4.6 on the iMX6UL EVK. The
> board mostly works and the only problem is audio.
> Even though the sound card is detected and the ALSA mixer can be controlled
> there is no MCLK coming out of the SAI2 interface.

Also, have you tried setting bit 20 (SAI2_MCLK_DIR) of register IOMUXC_GPR_GPR1?

You can set this bit in the bootloader for a quick test.
