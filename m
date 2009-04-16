From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] hdspm: native float
Date: Thu, 16 Apr 2009 13:41:59 +0100
Message-ID: <20090416124159.GN16318@sirena.org.uk>
References: <1239883941.10715.26.camel@x200.watzmann.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 551862433C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 14:42:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239883941.10715.26.camel@x200.watzmann.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 02:12:21PM +0200, Florian Faber wrote:

> > > It is a global change. The only use case is for jack, and jack doesn't
> > > use different formats for input/output.
> > "Using aplay + arecord" is a second use case.  :-)

> And they would willingly choose different formats?

A moderately common case is recording voice quality audio (at 8kHz or
so) and playing back higher quality audio.
