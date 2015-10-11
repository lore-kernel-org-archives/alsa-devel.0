From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v4 5/8] clk: rockchip: Allow the RK3288
	SPDIF clocks to change their parent
Date: Sun, 11 Oct 2015 12:43:27 +0200
Message-ID: <1745884.LUbKvMh2Tj@diego>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <11755202.f1LLWMlYi0@phil> <1444390555.9895.271.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gloria.sntech.de (gloria.sntech.de [95.129.55.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CFF26063A
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 12:43:33 +0200 (CEST)
In-Reply-To: <1444390555.9895.271.camel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Sjoerd,

Am Freitag, 9. Oktober 2015, 13:35:55 schrieb Sjoerd Simons:
> On Thu, 2015-10-08 at 17:10 +0200, Heiko Stuebner wrote:
> > Am Donnerstag, 8. Oktober 2015, 15:31:16 schrieb Sjoerd Simons:
> > > The clock branches leading to sclk_spdif and sclk_spdif_8ch on
> > > RK3288
> > > SoCs only feed those clocks, allow those clocks to change their
> > > parents
> > > all the way up the hierarchy.
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > 
> > Just as comment, if I'm seeing that right, this patch needs "clk:
> > rockchip:
> > handle mux dependency of fractional dividers" and friends [0] to
> > apply and
> > also actually handle the fractional dividers correctly.
> > 
> > For the clock change itself:
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Oh sorry yes, i completely forgot to at that as note on this patch
> (series). These are on top of your series as those are required to make
> things actually work as expected.
> 
> Which reminds me, i was wondering how to best move that forward. Could
> you pick this one up to include it in the next round of your series?
> (Otherwise i'm happy to rebase it once you do a v2)

I guess that will depend on how the core series gets handled. Aka if there 
needs to be a v2 (depending on the clock maintainers) I can pick that up as 
part of it. Otherwise we'll just need to ping the clock-maintainers separately 
on this patch if necessary.


Heiko
