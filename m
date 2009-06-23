From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Correct bypass event for
 voice sidetone
Date: Tue, 23 Jun 2009 10:57:03 +0100
Message-ID: <20090623095703.GE5422@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3555FB1F@dlee04.ent.ti.com>
	<200906230818.44470.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F1B192462B
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 11:57:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906230818.44470.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2009 at 08:18:44AM +0300, Peter Ujfalusi wrote:
> On Tuesday 23 June 2009 03:34:07 ext Lopez Cruz, Misael wrote:
> > Event for voice sidetone was being interpreted as an
> > analog HiFi bypass event because VSTPGA register offset
> > is less than ARXR2_APGA_CTL offset. Reordering the
> > register checks allows to handle voice digital bypass
> > event properly.

> > Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
