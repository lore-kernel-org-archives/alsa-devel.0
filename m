From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/4] ASoc: kirkwood: merge kirkwood-i2c
	and	kirkwood-dma
Date: Sat, 3 Aug 2013 12:43:21 +0100
Message-ID: <20130803114321.GW23006@n2100.arm.linux.org.uk>
References: <20130731081806.244752d4@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6F4DA260202
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 13:43:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130731081806.244752d4@armhf>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 08:18:06AM +0200, Jean-Francois Moine wrote:
> To avoid the declaration of a 'kirkwood-pcm-audio' device in the DT,
> this patch merges the kirkwood-i2c and kirkwood-dma drivers into one
> module associated with 'kirkwood-i2s'. 

This is broken unless you use my patch.  You can't just stick the
two drivers together because they both make use of the platform
device's driver data field for two incompatible uses.  I've already
explained that, and I've even sent you a patch to fix that, but you
seem to ignore anything that you didn't write.

So... I'm going to work on this issue this weekend and merge the two
drivers myself, and send Mark my own patches to do this.
