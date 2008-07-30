From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: multiple identical controls
Date: Wed, 30 Jul 2008 14:29:34 +0100
Message-ID: <20080730132934.GD6813@sirena.org.uk>
References: <9e4733910807291636q34148c2br357e986cddaa37e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0302496D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 15:29:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807291636q34148c2br357e986cddaa37e6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 29, 2008 at 07:36:13PM -0400, Jon Smirl wrote:

> Why is snd_soc_cnew() setting index to zero?

No great reason - previous users haven't needed to set index.  Looking
at the code the assignment in there should probably just be removed, the
source template is usually static anyway.
