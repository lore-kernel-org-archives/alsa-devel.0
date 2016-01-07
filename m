From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC v2 3/6] ASoC: mediatek: Add HDMI dai-links in
 the machine driver
Date: Thu, 07 Jan 2016 11:06:10 +0100
Message-ID: <1452161170.4776.9.camel@pengutronix.de>
References: <1451934551-21333-3-git-send-email-p.zabel@pengutronix.de>
 <1451934944-24588-1-git-send-email-p.zabel@pengutronix.de>
 <20160105124603.GB16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6DEED265546
 for <alsa-devel@alsa-project.ORg>; Thu,  7 Jan 2016 11:06:15 +0100 (CET)
In-Reply-To: <20160105124603.GB16023@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Am Dienstag, den 05.01.2016, 12:46 +0000 schrieb Mark Brown:
> On Mon, Jan 04, 2016 at 08:15:44PM +0100, Philipp Zabel wrote:
> > From: Koro Chen <koro.chen@mediatek.com>
> > 
> > This creates pcmC0D2p for the HDMI playback in the same card.
> > 
> > Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Please don't send new patches in reply to the middle of an existing
> series, it makes it very hard to tell what's going on.  If you need to
> send a new version resend the whole series.

Sorry, I had to manually restart an aborted git send-email and
accidentally chose the wrong --in-reply-to Message-Id for this patch.
It's all just one series.

regards
Philipp
