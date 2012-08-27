From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 4/6] ASoC: Davinci: McASP: add device
 tree support for McASP
Date: Mon, 27 Aug 2012 11:08:25 -0700
Message-ID: <20120827180824.GR4339@opensource.wolfsonmicro.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-5-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58199265E85
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 20:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346074004-22172-5-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-user@lists.sourceforge.net, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2012 at 06:56:42PM +0530, Hebbar, Gururaja wrote:

> +- sram-size-playback : size of sram to be allocated during playback
> +- sram-size-capture  : size of sram to be allocated during capture

These smell like runtime/policy configuration rather than fixed
properties of the device so it probably shouldn't appear in the device
tree, ideally at some point in the future we'll be able to work out some
wonderful way of automatically allocating the resources.

That said if the rest of the series looks OK I'll apply this but it'd be
nice to get these numbers from somewhere else.
