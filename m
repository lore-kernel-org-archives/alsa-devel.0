From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: Building alsa with kernel 2.6 when O= option used.
Date: Thu, 22 Jul 2004 19:13:38 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040722191339.9763.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: eliot@blennerhassett.gen.nz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, 

I got a bit further

> should I be able to build alsa 1.0.5a if I have built the kernel as follows?
> #cd /usr/src/linux
> #make O=~/build/kernel

To get configure to work, I had to copy ~/build/kernel/include/linux/* to the
corresponding dir in /usr/src/linux
(I shouldn't have to do this, instead something like 
	configure --with-kernel-build=~/build/kernel
)

Then
 make O=~/build/kernel

appears to be working, until it conks out building acore/memalloc.c

/acore/memalloc.c:63: error: conflicting types for `snd_malloc_sgbuf_pages
(but I seem to remember a thread about this, need to hunt back through the ML)

- Eliot


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
