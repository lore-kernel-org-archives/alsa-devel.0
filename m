From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need general idea how to architect driver
	for	multi-codec board
Date: Fri, 27 May 2011 02:27:56 +0100
Message-ID: <20110527012756.GA26768@sirena.org.uk>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA1F0103804
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 03:28:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
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

On Thu, May 26, 2011 at 02:23:03PM -0700, Caleb Crome wrote:

>    You previously indicated that I can instantiate multiple tlv320aic33
> drivers.  Can you please give me a clue how to do that?  I've been staring
> at this for days, and I still don't really get how it's supposed to be done.

With things like this it's always useful to look for other examples of
whatever it is you're doing - there's systems like speyside and rx51 in
mainline.

> fails because there are already controls with those names, like "Right PGA
> Mixer" etc.  The alsa layer doesn't seem to allow multiple registrations of
> the same control.  How do I give each instantiation a unique identifier?

Set up a snd_soc_codec_conf for each CODEC and assign a name_prefix to
it.  

>  Since the tlv320aic33 has about 80 controls, I'm going to end up with over
> 600 controls in alsamixer.

Yes.
