From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: auto-loading board-specific modules
Date: Wed, 7 Sep 2011 23:35:35 +0100
Message-ID: <20110907223535.GA9557@sirena.org.uk>
References: <CAG5Tg6VzdgPLG4L9how4-L8SJHVrEk+Twh9QcKnVF_-rVPka+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C237243B6
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 00:35:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAG5Tg6VzdgPLG4L9how4-L8SJHVrEk+Twh9QcKnVF_-rVPka+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans.rullgard@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 07, 2011 at 11:16:47PM +0100, Mans Rullgard wrote:

Always CC maintainers.  Please folks, this shouldn't be hard to work
out.

> Currently in ASoC, there is for each supported board a module describing the
> board-specific DAI links by creating a "soc-audio" platform device with an
> associated struct snd_soc_card.

No, this has not been the case for new drivers for quite some time now
and new drivers trying to do this get rejected.  You should probe using
a regular device and use snd_soc_register_card() to register the card.
