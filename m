From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/19] Documentation: Define the MOP500
 Audio Machine Driver Device Tree bindings
Date: Tue, 31 Jul 2012 14:53:37 +0100
Message-ID: <20120731135337.GM4468@opensource.wolfsonmicro.com>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3ACB265D14
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 15:53:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 02:39:11PM +0100, Lee Jones wrote:

> +Required properties:
> + - compatible                : "stericsson,snd-soc-mop500"

> +Non-standard properties:
> + - Machine Driver:
> +   - stericsson,cpu-dai      : Phandle to the CPU-side DAI
> +   - stericsson,audio-codec  : Phandle to the Audio CODEC

You should also support the card name property (there's a helper to
parse it, you can define the name of the property though) so apps can
tell what board they're on.
