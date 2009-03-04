From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack
	reporting	interface
Date: Wed, 4 Mar 2009 14:52:45 +0000
Message-ID: <20090304145245.GF433@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6DD49@dlee07.ent.ti.com>
	<20090304144313.GC433@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F25A21037F4
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 15:52:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304144313.GC433@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 02:43:14PM +0000, Mark Brown wrote:

> Applied, thanks.  However, I'll provide a follow on patch to...

> > +undo:
> > +	snd_soc_jack_free_gpios(jack, i, gpios);

> change this to i + 1 - confusion due to zero based indexing.

Eh, no I won't - there's no case where it's required.  Sorry about the
confusion.
