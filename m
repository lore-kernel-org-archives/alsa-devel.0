From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: Re: C-Media testing
Date: Sat, 19 Feb 2005 20:11:56 +0100
Message-ID: <42178F7C.7020308@gmx.de>
References: <1108782279.23185.38.camel@bastov>  <4216B80C.2090507@gmx.de> <1108830414.26083.19.camel@bastov>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040905030807080109090209"
In-Reply-To: <1108830414.26083.19.camel@bastov>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sergio@sergiomb.no-ip.org
Cc: Jakob Schurdak <jakobs@myrealbox.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040905030807080109090209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sergio Monteiro Basto wrote:
> Hello,
> Alsa-webmaster please read the end of message and improve your
> http://www.alsa-project.org/download.php page !
> 
> Well mine is:
> lspci -v
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
>         Subsystem: ASRock Incorporation: Unknown device 9739

thats the CMI9739.

http://www.cmedia.com.tw/product/CMI9739.htm


> I finished to test last sources of the CVS, I back to first state, no
> improves, no master again.
> 

thx.

> For Jakob and alsa-webmaster, a little fast How to compile alsa from
> CVS:
> 
> yum -y install gettext-devel.i386 ( you will need this for cvscompile
> alsa-utils and you will need autotools ) 
> 
> service alsasound stop (or rmmod all snd-*)
> 
> cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
> (enter)
> cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-driver
> cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-kernel
> cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-lib
> cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-utils

i prefer using the kde cervisia frontend in konqueror, you get a better 
overview of versions and logs then. its fine.

> cd alsa-driver
> cvscompile (stop when enter in configure, because will compile drives
> for all cards and we just need for our via82xx) 

i use only this:

  ./configure --with-cards=via82xx

> make
su
> make install
> modprobe snd-via82xx
exit

heres a script for testing automation (edit for your needs):

att.

> 
> cd ../alsa-lib
> cvscompile && make install && ldconfig
> cd ../alsa-utils
> cvscompile && make install 

? i dont use the userspace from cvs, only the debian 1.08 distri packages.

tom

> 
> regards,
> 

--------------040905030807080109090209
Content-Type: application/x-shellscript;
 name="inserttestmodules.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="inserttestmodules.sh"

IyEvYmluL3NoCgpraWxsYWxsIGt2ZHIKa2lsbGFsbCBrbWl4CmtpbGxhbGwgYXJ0c2QKa2ls
bGFsbCB4aW5lCmtpbGxhbGwgeG1tcwpzbGVlcCAxCi9iaW4vcm0gL3Zhci9saWIvYWxzYS9h
c291bmQuc3RhdGUKL3NiaW4vbW9kcHJvYmUgIC1yIHNuZF9idDg3eAovc2Jpbi9tb2Rwcm9i
ZSAgLXIgc25kX3ZpYTgyeHgKL3NiaW4vbW9kcHJvYmUgLXIgc25kX3BjbV9vc3MKc2xlZXAg
Mgovc2Jpbi9tb2Rwcm9iZSBzbmRfdmlhODJ4eApzbGVlcCAzCi9iaW4vc3UgLWMga21peCBz
Y2hvcnBwCgoKCgogCg==
--------------040905030807080109090209--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
