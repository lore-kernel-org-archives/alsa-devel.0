From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: alsa-conf will not compile.
Date: Sat, 29 Jun 2002 21:37:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1E0C7B.AFDB896F@folkwang-hochschule.de>
References: <3D17B909.20006@superbug.demon.co.uk> <s5hofdy56ko.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James@superbug.demon.co.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Tue, 25 Jun 2002 01:27:53 +0100,
> James Courtier-Dutton wrote:
> >
> > Has anyone managed to get "alsa-conf" to compile ?
> >
> > I use the current CVS, but it will not compile.
> > Is "alsa-conf" of any use any more ?
> 
> no, it's not maintained atm.
> it was designed for the old system.  since then, some things have been
> changed.
> 
> iirc the following problems have to be solved:
> 
> - rewrite the parser for outputs of new modprobe/modinfo
> - rewrite the code to use snd-xxx instead of snd-card-xxx
> - the module syntax description was moved from the built-in module
>   description to /lib/modules/XXX/modules.generic_string.
>   the parser must look at the latter file.
> 

since SuSE 8.0 autoconfigures ALSA in a breeze, perhaps they might be
willing to share some of their yast2 magic ? ;) <hint />


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
