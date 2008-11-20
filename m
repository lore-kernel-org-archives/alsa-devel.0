From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Kcontrols for ASoC TWL4030 CODEC
Date: Thu, 20 Nov 2008 14:04:06 +0000
Message-ID: <20081120140405.GF4539@sirena.org.uk>
References: <ef0d8a250811200442j3146441cgc4650153974e62d6@mail.gmail.com>
	<20081120133644.GE4539@sirena.org.uk>
	<ef0d8a250811200601n5bcede89xb442dc26cb05fe8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3133124391
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:04:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811200601n5bcede89xb442dc26cb05fe8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 07:31:15PM +0530, naveen krishna ch wrote:
> On Thu, Nov 20, 2008 at 7:06 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> >        Documentation/sound/alsa/ControlNames.txt

> The standard names in the documentation does not gives the exact details of
> the CODEC's feature so i used a part of the CODEC pin name to avoid
> confusion at later stages.

You'll not be able to get all the control names entirely from the spec
but you should still do things like use "Volume" for gain and
attenuation controls as I said.
