From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 15 Mar 2009 11:26:40 +0000
Message-ID: <20090315112638.GA7439@sirena.org.uk>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
	<20090314224648.GB6523@sirena.org.uk> <87d4cjghrp.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09FAE24330
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 12:26:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87d4cjghrp.fsf@free.fr>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 15, 2009 at 12:14:18PM +0100, Robert Jarzmik wrote:

> You assume a reset gpio is _always_ provided on pxa27x CPUs. I do not. There may
> be faulty boards where no gpio line is dedicated to AC97 reset, or AC97 reset
> line is commanded by a helper chip.

Could you change this to provide an explicit way of specifying that (eg,
with -1 as the GPIO)?  There are other things we might want platform
data for in future - passing data to the AC97 codec, for example - so we
can't rely on people not specifying platform data for anything.
