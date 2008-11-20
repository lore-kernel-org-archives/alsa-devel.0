From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 12:52:16 +0000
Message-ID: <20081120125215.GD4539@sirena.org.uk>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
	<20081120112304.GB4539@sirena.org.uk>
	<dfeb90390811200351t20a43ecfp39705234e0bce180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E403B24363
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 13:52:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <dfeb90390811200351t20a43ecfp39705234e0bce180@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <getarunks@gmail.com>
Cc: naveen krishna ch <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 05:21:48PM +0530, Arun KS wrote:

> By 'defaults' did you mean the reset values of the codec registers?

For most codecs it would be.  The PMIC-integrated codecs are a bit
special here due to the always on nature of PMICs.
