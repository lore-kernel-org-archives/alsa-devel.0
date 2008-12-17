From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: aplay..no sound..no error..
Date: Wed, 17 Dec 2008 11:03:19 +0000
Message-ID: <20081217110318.GB22204@sirena.org.uk>
References: <eeb9eca50812162338k2bf33772w32333fa55e842be@mail.gmail.com>
	<ef0d8a250812162345p6bd611dcwe5ec3293ea0e91e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D61731037E3
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 12:03:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250812162345p6bd611dcwe5ec3293ea0e91e1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, vasudha rao <vasudha.jrao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 17, 2008 at 01:15:58PM +0530, naveen krishna ch wrote:
> On Wed, Dec 17, 2008 at 1:08 PM, vasudha rao <vasudha.jrao@gmail.com> wrote:

> > I am not getting any error message.. But no sound from speaker also..

> > What else I can try to listen sound from speaker..??

> Have u seen the amixer settings for speaker (enabled or not)

I would expect this is the issue if no other errors are being produced.
By default most codecs don't enable any outputs - normally there are
many outputs to choose from so it's hard for a sensible default to be
provided.
