From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] mfd: ab8500-core: Apply the AB8500
 CODEC's compatible string to its MFD cell
Date: Sun, 29 Jul 2012 21:28:07 +0100
Message-ID: <20120729202806.GC4384@opensource.wolfsonmicro.com>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
 <20120727133633.GQ16859@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D7D5265218
 for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2012 22:28:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120727133633.GQ16859@sortiz-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2012 at 03:36:33PM +0200, Samuel Ortiz wrote:
> On Fri, Jul 27, 2012 at 01:38:51PM +0100, Lee Jones wrote:

> > Provide a compatible string for the AB8500 CODEC to aid in
> > configuration property look-up from its associated Device Tree
> > node.

> Applied as well.

I remain *deeply* unconvinced that this is tasteful design for the
device tree bindings, and it's certainly not needed urgently for v3.6 as
there's no DT bindings on the CODEC side.
