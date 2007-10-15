From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] How to get set/fixed sample rate of
 ALSA device?
Date: Mon, 15 Oct 2007 22:20:10 +0200
Message-ID: <4713CB7A.7070304@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>	<4708F918.3060207@keyaccess.nl>	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>	<470958A9.7040607@keyaccess.nl>	<b97f4ee40710081209k1ba59df3g491387b681f8bbe3@mail.gmail.com>	<Pine.LNX.4.64.0710081212360.32693@info.physics.ubc.ca>	<470A8562.50301@keyaccess.nl>
	<470ACA07.8080407@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 08A72244E2
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 22:22:10 +0200 (CEST)
In-Reply-To: <470ACA07.8080407@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peteris Krisjanis <pecisk@gmail.com>, alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Bill Unruh <unruh@physics.ubc.ca>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 10/09/2007 02:23 AM, Rene Herman wrote:

> Not too sure about that subformat thing by the way. Jaroslav (or anyone, 
> obviously): is the subformat intended/designed to be format-specific or 
> snd_pcm_t global?
> 
> Currently there is only ever one subformat (STD) anyway but generally, 
> I'd expect a subformat to be specific to a given format. There's just 
> one non format-specific SND_PCM_SUBFORMAT_LAST though, no defines (or 
> functions) to get subformats from the format. Is the design that all 
> formats would be supporting all subformats or something?

Takashi, with Jaroslav his usual blackhole self -- do you know what the idea 
is of the subformats?

Rene.
