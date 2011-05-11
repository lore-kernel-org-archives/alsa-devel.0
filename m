From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need general idea how to architect driver
	for	multi-codec board
Date: Wed, 11 May 2011 18:50:21 +0100
Message-ID: <20110511175021.GB22798@sirena.org.uk>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 00894247D6
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:50:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2011 at 10:31:15AM -0700, Caleb Crome wrote:

> 1)  Simply instantiate multiple TLV320IAC33 codec drivers, as the AIC33
> driver is already written.

Yes.

>     This seems like it won't work because I'd end up with multiple
> user-space 'cards', yet I want the card to appear as a single 16-channel
> sound card.  Also, when you start one PCM interface for one codec, they

No, you shouldn't.  You'll end up with a single card.

> would all start automatically, which I imagine the linux system wouldn't
> get.  Also, the PCM interface needs to be configured differently for each
> codec (the TDM offset must be 0, 16, 32, 48, etc. bits).

The TDM stuff should be configured with the existing TDM API (you may
need to implement this in the CODEC driver).
