From: Pavel Roskin <proski@gnu.org>
Subject: Re: Re: pkg-config
Date: Wed, 18 Sep 2002 15:46:16 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209181532150.6236-100000@marabou.research.att.com>
References: <20020918212600.T19700@thot.informatik.uni-kl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020918212600.T19700@thot.informatik.uni-kl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Joerg Mayer <jmayer@loplof.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> I don't think forcing people to install pkg-config is the right thing
> to do. Move that off for a year or so as pgk-config is pretty new
> (AFAIK, glib (v1) and gtk (v1) haven't removed thei .m4 files either
> when they added pkg-config files. Once gtk2 and glib2 are in more
> common use, many developers will have pkg-config installed. Do not
> add this problem to the current distribution.

For your information, even the CVS version of glib (head branch) includes
two macro files glib-2.0.m4 (which is a wrapper around pkgconfig) and
glib-gettext.m4.  Macro files are not dead and not obsoleted by pkgconfig.

Consider that the latest version is 0.12.0.  Consider that it's not 
widely used.  Consider that pkgconfig is implemented in C, so you cannot 
distribute it in tarballs like libtool or install-sh.

It's great that we have a pkgconfig file for alsa-lib.  Let's see how well
it works for ALSA.  But it's too early to remove or obsolete anything else
_because_ pkgconfig is supported.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
