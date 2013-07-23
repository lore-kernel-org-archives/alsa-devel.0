From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: kirkwood: enable S/PDIF
Date: Tue, 23 Jul 2013 09:43:47 +0100
Message-ID: <20130723084347.GP24642@n2100.arm.linux.org.uk>
References: <20130723102320.56bc4555@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DB9B4261AEE
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 10:44:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130723102320.56bc4555@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 10:23:20AM +0200, Jean-Francois Moine wrote:
> This patch enables S/PDIF.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

I'm not submitting my patch to do this because:

(a) we don't know what effect this has on other hardware.
(b) Mark suggested that we use the slave PCM stuff to deal with this.  As
    yet, that's something which I haven't been able to get to grips with
    because ASoC is soo damned complicated and undocumented.
