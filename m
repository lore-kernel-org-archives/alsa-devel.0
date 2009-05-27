From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: skype and old alsa RC4 symbols
Date: Wed, 27 May 2009 20:40:41 +0200
Message-ID: <20090527184041.GA3549@aragorn.home.lxtec.de>
References: <9e4733910904081455u181eecebi31837f490cfd85@mail.gmail.com>
	<9e4733910904100913h8cd0466m21b3815030ad32fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 065C62459F
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 20:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904100913h8cd0466m21b3815030ad32fb@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Luke Yelavich <luke@audioslack.com>
List-Id: alsa-devel@alsa-project.org

* Jon Smirl [090410 12:13 -0400]
> On Wed, Apr 8, 2009 at 5:55 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I would like to run pulseaudio 9.15 contained in this ubuntu
> > repository since it fixes my problems with S/PDIF
> > https://launchpad.net/~themuso/+archive/ppa
> 
> I finally fixed this by hacking around to define -DUSE_VERSIONED_SYMBOLS.
> 
> Something is wrong in the build process for these packages.

Isn't it the same to use --with-vesioned in ./configure options?

Elimar

-- 
  Learned men are the cisterns of knowledge, 
  not the fountainheads ;-)
