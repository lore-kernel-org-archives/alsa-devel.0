From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
	device SoC.
Date: Wed, 9 Jul 2008 15:15:23 +0100
Message-ID: <20080709141456.GB10399@sirena.org.uk>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E88924414
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 16:22:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 08, 2008 at 10:45:05PM +0200, Robert Jarzmik wrote:

> It doesn't cope with :
>  - headset jack (will be integrade after jack support has
>    hit ASoC v2)

My intention is to provide some additional ASoC wrappers for the generic
jack functionality with DAPM integration allowing pin status to be
managed automatically based on the jack status.  I'm waiting for the
generic support to be merged before starting on this.
