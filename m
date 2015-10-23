From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH v4 2/2] ASoC: nau8825: Show device
	properties
Date: Thu, 22 Oct 2015 18:48:50 -0700
Message-ID: <CAOV7By+yBAiCOB=QBE3i6pc=0hs04ZNsBF_Rhzr_fqG_Lp-QXg@mail.gmail.com>
References: <1445298546-23975-1-git-send-email-benzh@chromium.org>
 <1445298546-23975-3-git-send-email-benzh@chromium.org>
 <20151022161756.GV8232@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 881B626145A
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 03:48:51 +0200 (CEST)
Received: by ykaz22 with SMTP id z22so102592173yka.2
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 18:48:50 -0700 (PDT)
In-Reply-To: <20151022161756.GV8232@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: John Hsu <KCHSU0@nuvoton.com>, alsa-devel <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 22, 2015 at 9:17 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 19, 2015 at 04:49:06PM -0700, Ben Zhang wrote:
>> The codec device properties are printed for debugging.
>
> Hrm...  we do already have multiple ways of dumping the DT...

Hi Mark,

Could you point me to some of the ways of dumping DT? Is there a
generic way of dumping device properties provided by ACPI _DSD?
Sometimes devices may be flashed with different versions of coreboot
firmware which contain different _DSD values. When debugging, it's
helpful to know the exact platform data seen by a codec driver.

Thanks,
Ben
