From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASOC deprecated warning
Date: Thu, 30 Oct 2008 19:51:08 +0000
Message-ID: <20081030195107.GA13678@sirena.org.uk>
References: <9e4733910810301222v360ecf8aqbbead50759a2b844@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F25B1037ED
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 20:51:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910810301222v360ecf8aqbbead50759a2b844@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 03:22:31PM -0400, Jon Smirl wrote:
> What's the status of this?

> Could we have a Kconfig option of disabling deprecated APIs?
> If I can get rid of this I'll have a warning free build.

The API is removed in ALSA git, you can cherry pick the patch over if
you want.  Otherwise I'd suggest taking it up with the people
maintaining the compiler infrastructure - there's no way to warn on use
of an API without also warning on the export of the API, which isn't
ideal.
