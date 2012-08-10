From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Fri, 10 Aug 2012 13:43:56 +0200
Message-ID: <CACRpkdZeYAnqg7HLi_bH51_=s60OZB7ySn1W+YQ=H9fz8xZUCg@mail.gmail.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
 <5018D880.5090306@linaro.org>
 <20120801132022.GS11892@opensource.wolfsonmicro.com>
 <003901cd7073$d49cacc0$7dd60640$@se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 02FEC266520
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 13:14:11 +0200 (CEST)
Received: by vbbfn1 with SMTP id fn1so1356985vbb.38
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 04:43:56 -0700 (PDT)
In-Reply-To: <003901cd7073$d49cacc0$7dd60640$@se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <olalilja@yahoo.se>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Philippe BEGNIC <philippe.begnic@stericsson.com>, STEricsson_nomadik_linux@list.st.com, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

(As for the thread, which got flamy, let's put it to rest, and Ola:
 we are all impressed with your work on the ux500 ALSA SoC
 driver, no doubt about that, this was all ever about the DT
 patch set.)

On Thu, Aug 2, 2012 at 7:58 AM, Ola Lilja <olalilja@yahoo.se> wrote:

> Linus W. could probably shed some light of when the missing clocks are to
> be submitted.

Ulf Hansson is working on this but he's on vacation FTM.
However he has shown good progress and can probably present
a prototype clock driver when he arrives back. IIRC there was
some clock reparenting business left to sort out.

Yours,
Linus Walleij
