From: Martin Langer <martin-langer@gmx.de>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Tue, 4 Mar 2003 17:40:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030304164059.GD511@tuba.home>
References: <Pine.LNX.4.44.0303041646420.2089-100000@pnote.perex-int.cz> <E18qEvh-0000x8-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18qEvh-0000x8-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 04, 2003 at 11:09:14AM -0500, Paul Davis wrote:
> >> module-init-tools 0.9.10
> >  ^^^^^^^^^^^^^^^^^
> >
> >Probably bug in this package. I don't know the exact status of modules in 
> >2.5 (it's dramaticaly changing), but all ALSA modules are GPLed, thus this 
> >problem shouldn't occur.
> 
> good first guess, but no luck. i uninstalled it, reinstalled modutils
> 2.4.9, and the same problem occurs. i don't understand how this
> happens: the kernel image contains only vmalloc_to_page, but
> /proc/ksyms has only the GPL version. i was hoping that someone with
> even more experience of this than i might have an idea what has gone
> wrong. it all works under 2.5 BTW, but i can't use 2.5 right now
> because the main serial driver is broken.
> 

Hmmmm don't know, but I found a small bug in hdsp.c.

martin



--- hdsp.c.ORIGINAL	Tue Mar  4 17:33:50 2003
+++ hdsp.c	Tue Mar  4 17:34:32 2003
@@ -72,7 +72,7 @@
 MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
-MODULE_DEVICES("{{RME,Hammerfall-DSP},");
+MODULE_DEVICES("{{RME,Hammerfall-DSP}}");
 
 typedef enum {
 	Digiface,


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
