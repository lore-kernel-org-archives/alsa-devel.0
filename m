From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-cvs linking error
Date: Mon, 7 Apr 2003 12:51:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304071250250.2574-100000@pnote.perex-int.cz>
References: <3E9153B1.6F8DC8A5@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E9153B1.6F8DC8A5@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Apr 2003, Andrei Boros wrote:

> 
> > 
> > Fixed in CVS. Thanks.
> 
> Just updated. New problems:
> 
> gcc -D__KERNEL__ -DMODULE=1
> -I/serve/install/alsa-cvs/alsa-driver/include  -I/usr/src/linux/include
> -O2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  
> -DEXPORT_SYMTAB -c pnp.c
> pnp.c:324: parse error before `pnp_exit'
> pnp.c:325: warning: return-type defaults to `int'
> pnp.c: In function `pnp_exit':
> pnp.c:326: warning: control reaches end of non-void function
> pnp.c: In function `__cleanup_module_inline':
> pnp.c:329: warning: return from incompatible pointer type
> make[2]: *** [pnp.o] Error 1
> make[2]: Leaving directory
> `/serve/install/alsa-cvs/alsa-driver/support/pnp'
> make[1]: *** [_modsubdir_pnp] Error 2
> make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/support'
> make: *** [compile] Error 1

Are you using 2.2 kernel? Please, try again. I've tried to fix this 
problem in CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
