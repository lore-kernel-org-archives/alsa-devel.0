From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Tue, 4 Mar 2003 16:48:34 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303041646420.2089-100000@pnote.perex-int.cz>
References: <200303041455.h24EtqT17634@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303041455.h24EtqT17634@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Mar 2003, Paul Davis wrote:

> i've been rebuilding kernels and drivers and stuff like that. after a
> complete new checkout of ALSA, a complete rebuild of 2.4.19 and of
> alsa-driver, then installing ALSA, i get this:
> 
> % sudo depmod -ae
> depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/acore/snd-pcm.o
> depmod:         vmalloc_to_page
> 
> % grep GPLONLY /proc/ksyms
> c012c980 GPLONLY_vmalloc_to_page
> 
> now, i know something the EXPORT_SYMBOL_GPLONLY, but i don't
> understand why this is happening.
> 
> linux 2.4.19 + ll
> ALSA CVS
> gcc 3.2.2
> module-init-tools 0.9.10
  ^^^^^^^^^^^^^^^^^

Probably bug in this package. I don't know the exact status of modules in 
2.5 (it's dramaticaly changing), but all ALSA modules are GPLed, thus this 
problem shouldn't occur.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
