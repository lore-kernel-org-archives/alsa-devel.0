From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 24 Aug 2010 10:41:50 +0100
Message-ID: <20100824094149.GA13042@sirena.org.uk>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<AANLkTingUF7Ad1z568kfkhNR3eQsQ5SmLvONnGTXqOiP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F78B24675
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 11:41:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTingUF7Ad1z568kfkhNR3eQsQ5SmLvONnGTXqOiP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 09:23:14AM +0800, Raymond Yau wrote:

> Can the use case manager discover whether the green/pink jack in front panel
> can be used independent of  those audio jacks in rear panel for HDA-Intel in
> desktop pc ?

> How about those hardware mixing sound card ?
> e.g. emu10k1 allow the user to output stereo to the selected  jacks (front ,
> rear, .... )

These are all orthogonal problems.  UCM just provides a way of managing
configurations exposed by the drivers, it doesn't add any new features
for the drivers.
