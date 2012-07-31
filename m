From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: ab8500: Inform SoC Core that we
 have our own I/O arrangements
Date: Tue, 31 Jul 2012 16:38:28 +0100
Message-ID: <20120731153827.GE4468@opensource.wolfsonmicro.com>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 367B7265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:38:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343745944-18418-3-git-send-email-lee.jones@linaro.org>
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

On Tue, Jul 31, 2012 at 03:45:41PM +0100, Lee Jones wrote:
> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:

Applied.  If you could do resends at a rate somewhat lower than once per
working day that'd be helpful, especially given the number of large
patch serieses that you're sending right now.
