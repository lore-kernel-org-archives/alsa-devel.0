From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 12/15] ASoC: twl6040: Enable plug	detection
	interrupts
Date: Tue, 7 Dec 2010 13:35:25 +0000
Message-ID: <20101207133525.GE10722@sirena.org.uk>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD2@dlee06.ent.ti.com>
	<20101207133416.GS4698@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EC98103BB4
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:35:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101207133416.GS4698@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 01:34:17PM +0000, Mark Brown wrote:
> On Mon, Dec 06, 2010 at 06:18:15PM -0600, Olaya, Margarita wrote:
> > From: Misael Lopez Cruz <misael.lopez@ti.com>
> > 
> > Enable plug detection interrupt mask in order to get headset
> > PLUGINT/UNPLUGINT interrupts.
> > 
> > Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> > Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> 
> Might it not be better to enable these interrupts only if the board has
> set up jack detection?  Otherwise you'll just get interrupts that don't
> serve any purpose which is a waste of time/power.

Sorry, meant to ack this though:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
