From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Sun, 29 Jul 2012 21:25:10 +0100
Message-ID: <20120729202510.GB4384@opensource.wolfsonmicro.com>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C870265218
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:25:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343392734-11805-2-git-send-email-lee.jones@linaro.org>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2012 at 01:38:48PM +0100, Lee Jones wrote:
> If a list of widgets is provided and one of them fails to be added as
> a control, the present semantics fail all subsequent widgets. A better
> solution would be to only fail that widget, but pursue in attempting
> to add the rest of the list.

You've completely ignored my question about why this is better.

This is also *clearly* not an urgent bugfix.
