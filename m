From: Ben Zhang <benzh@google.com>
Subject: Re: [PATCH v3 1/2] ASoC: nau8825: Add FLL configuration
Date: Mon, 19 Oct 2015 16:56:15 -0700
Message-ID: <CAOV7ByJs4Fnu9VBHJWb7Q74ZnmJRrp4bJf=2XXLXgFGEd_=Xcg@mail.gmail.com>
References: <1444427341-7135-1-git-send-email-benzh@chromium.org>
 <1444452616-32903-1-git-send-email-benzh@chromium.org>
 <20151019152557.GB32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 302A22652C5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:56:16 +0200 (CEST)
Received: by ykdr3 with SMTP id r3so1191544ykd.1
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 16:56:15 -0700 (PDT)
In-Reply-To: <20151019152557.GB32054@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, kbuild test robot <lkp@intel.com>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol@google.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 19, 2015 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 09, 2015 at 09:50:16PM -0700, Ben Zhang wrote:
>> snd_soc_codec_driver.set_pll is implemented to configure the FLL.
>> The codec internal SYSCLK can be from either the MCLK pin directly,
>> or the FLL. This is configured by snd_soc_codec_driver.set_pll.
>
> Please don't post new patches in the middle of an existing series, and
> please don't post partial patch serieses - both makit it hard to follow
> what's going on and what the current version is.  As it is I'm a bit
> confused as I have a v3 1/2 but no 2/2...

Sorry about the confusion. I uploaded a complete v4 patch series which
is the latest version. Won't post partial update again. Please ignore
all the previous versions.

Ben
