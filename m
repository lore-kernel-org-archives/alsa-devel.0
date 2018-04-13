From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] ALSA: hda - Silence PM ops build warning
Date: Fri, 13 Apr 2018 06:27:06 +0200
Message-ID: <20180413042706.GA425@wunner.de>
References: <b8e70e34a9acbd4f0a1a6c7673cea96888ae9503.1522323444.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DCF5266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 06:27:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b8e70e34a9acbd4f0a1a6c7673cea96888ae9503.1522323444.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2018 at 01:46:26PM +0200, Lukas Wunner wrote:
> sound/pci/hda/hda_intel.c:1024:12: warning: 'azx_resume' defined but not used [-Wunused-function]
>  static int azx_resume(struct device *dev)
>             ^~~~~~~~~~
> sound/pci/hda/hda_intel.c:989:12: warning: 'azx_suspend' defined but not used [-Wunused-function]
>  static int azx_suspend(struct device *dev)
>             ^~~~~~~~~~~

Arnd, Takashi, just a quick FYI that the fix for the above-quoted
warnings has landed in Linus' tree half an hour ago.  Thanks for
your patience.

Lukas
