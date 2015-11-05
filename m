From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC] ASoC: Add mediatek HDMI codec driver
Date: Thu, 05 Nov 2015 16:15:19 +0100
Message-ID: <1446736519.3894.113.camel@pengutronix.de>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
 <20151104120343.GZ20228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1B49C266176
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 16:15:21 +0100 (CET)
In-Reply-To: <20151104120343.GZ20228@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Am Mittwoch, den 04.11.2015, 12:03 +0000 schrieb Mark Brown:
> On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:
> 
> > This driver is based on the work of DW HDMI codec driver.
> > It controls mediatek HDMI Tx's audio module, and handles
> > HDMI jack detection by sharing IRQ with HDMI Tx.
> 
> How does this relate to all the other HDMI related work that's going on,
> especially around handling of the EDID data?  I'm not seeing anything in
> here that uses the constraints code that Russell added for example. 

So I'll use snd_pcm_hw_constraint_eld.

> As I keep saying I really want to see some collaboration and consensus
> here with the goal of sharing code and achieving a consistent userspace
> interface rather than a lot of individual independently implemented
> drivers.

For eld updates and jack handling I could try to go forward with
Russell's notification prototype from the "[RFC,V2,0/5] another generic
audio hdmi codec proposal" thread:
https://patchwork.kernel.org/patch/7339011/

Or are you saying there shouldn't be a Mediatek specific HDMI sound
driver at all and this should be handled by generic code?

regards
Philipp
