From: Joerg Mayer <jmayer@loplof.de>
Subject: Re: pkg-config
Date: Wed, 18 Sep 2002 21:26:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918212600.T19700@thot.informatik.uni-kl.de>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz> <E17rfBE-0001EJ-00@usw-sf-list1.sourceforge.net> <s5hbs6vqm0w.wl@alsa2.suse.de>
Reply-To: Joerg Mayer <jmayer@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hbs6vqm0w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2002 at 06:51:11PM +0200, Takashi Iwai wrote:
> is there any problem to keep alsa.m4 file?  or should it be removed
> and force people to move to pkg-config from AC macros?

I don't think forcing people to install pkg-config is the right thing
to do. Move that off for a year or so as pgk-config is pretty new
(AFAIK, glib (v1) and gtk (v1) haven't removed thei .m4 files either
when they added pkg-config files. Once gtk2 and glib2 are in more
common use, many developers will have pkg-config installed. Do not
add this problem to the current distribution.

 ciao
       J=F6rg
--
Joerg Mayer                                          <jmayer@loplof.de>
I found out that "pro" means "instead of" (as in proconsul). Now I know
what proactive means.


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
