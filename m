From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 14:21:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
References: <20020918120235.49273.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020918120235.49273.qmail@web40601.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Sep 2002, [iso-8859-1] Chris Rankin wrote:

>  --- Jaroslav Kysela <perex@perex.cz> wrote: > On Wed,
> 18 Sep 2002, Chris Rankin wrote:
> > Note: If
> > SND_COMPATIBILITY_BUILD_RC3 is defined, 
> > then applications need to fall back to 0.9.0rc3 API
> > as well.
> 
> So maybe we could have a --with-compat-rc3 option for
> alsa-utils as well? Regardless of which alsa-lib I
> build, I always need to be able to build alsa-utils.
> And I doubt that wine and xine will get updated before
> -rc4 is released. (Unless there's a document somewhere
> explaining the relationship between the old and new
> API functions, in which case I could submit patches
> myself.)

It seems, that you're not understand the compatibility.

1) build library with --with-compat-rc3 and place it to some
   other directory
3) build library without --with-compat-rc3, place it to
   /usr/lib as usuall
4) build alsa-utils and newer applications
5) build older applications with compatible library compiled
   with --with-compat-rc3

Old and new software will co-exist without any problems. Perhaps, we
can have some good default place for rc3 compatible library and add an 
autoconfiguration code to alsa.m4. My suggestion is to use /opt/alsa/rc3 
directory for this job. Comments?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
