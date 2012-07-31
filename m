From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 16:15:59 +0100
Message-ID: <20120731151559.GB4468@opensource.wolfsonmicro.com>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
 <20120731145614.GZ4468@opensource.wolfsonmicro.com>
 <5017F514.4030106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B384C265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:15:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5017F514.4030106@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 04:09:08PM +0100, Lee Jones wrote:
> On 31/07/12 15:56, Mark Brown wrote:

> >To reiterate, this is in *no* way urgent or even a bug fix.

> It fixes sound in our driver.

> Without this the card failes to instantiate.

You're kidding, right?  Fix the actual error.

> Isn't the return code incorrect? There are a multitude of reasons
> why snd_soc_dapm_new_control() would fail. No-memory is just one of
> them, so why do we force this probable lie?

I don't think anyone actually cares what the error code is, feel free to
pick another random number.
