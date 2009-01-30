From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: kerneldoc for sound drivers?
Date: Fri, 30 Jan 2009 12:01:09 +0000
Message-ID: <20090130120108.GC18825@sirena.org.uk>
References: <ed82fe3e0901291447i14a04c54q24525bddfaa2048d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C957D1037FA
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 13:01:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0901291447i14a04c54q24525bddfaa2048d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 04:47:22PM -0600, Timur Tabi wrote:
> I'm fixing the comments in my driver (sound/soc/codecs/cs4270.c) to
> conform to kerneldoc standards.  However, when I build "make
> htmldocs", my comments aren't processed.  I presume the make rules
> don't know to look into the sound/soc/codecs directory.  How do I fix
> this?

make htmldocs builds the manuals in Documentation/DocBook into HTML.
