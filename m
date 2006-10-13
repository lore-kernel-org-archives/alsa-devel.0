From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa-lib fails to compile.
Date: Fri, 13 Oct 2006 15:24:35 +0100
Message-ID: <452FA1A3.5020407@superbug.co.uk>
References: <452FA0DC.802@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <452FA0DC.802@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Hi,
> 
> The latest alsa-lib HG fails to compile.
> Does anyone know why?
> 
> James
> 
> 
> 
> if /bin/sh ../../libtool --tag=CC --mode=compile gcc -DHAVE_CONFIG_H -I.
> -I. -I../../include -I../../include    -O2 -Wall -W -pipe -g -MT
> pcm_null.lo -MD -MP -MF ".deps/pcm_null.Tpo" -c -o pcm_null.lo pcm_null.c; \
> 	then mv -f ".deps/pcm_null.Tpo" ".deps/pcm_null.Plo"; else rm -f
> ".deps/pcm_null.Tpo"; exit 1; fi
>  gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -O2 -Wall
> -W -pipe -g -MT pcm_null.lo -MD -MP -MF .deps/pcm_null.Tpo -c pcm_null.c
>  -fPIC -DPIC -o .libs/pcm_null.o
> make[2]: *** No rule to make target `pcm_empty.lo', needed by
> `libpcm.la'.  Stop.
> make[2]: Leaving directory `/u/alsahg/alsa-lib.enum1/src/pcm'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/u/alsahg/alsa-lib.enum1/src'
> make: *** [all-recursive] Error 1
> 

I have found out why.

the HG is missing the file "pcm_empty.c".

Can someone please add this?

James


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
