From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Thu, 7 May 2009 11:09:16 +0100
Message-ID: <20090507100915.GB27897@sirena.org.uk>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A77710387D
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 12:09:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbpq5s3fx.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 10:49:22AM +0200, Takashi Iwai wrote:

> IMO, the best would be a total rewrite of the current mixer API, as I
> mentioned some times.  Right now it's more complicated than needed,
> but not powerful enough to handle exceptional cases.

Indeed - for example, something that allowed audio routing to be
expressed in the mixing API would be a very big win for embedded systems
too.

> I know designing a generic and fully-working API is pretty difficult,
> though...

Certainly non-trivial :)
