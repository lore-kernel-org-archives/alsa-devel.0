From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: How to detect whether OSS mixer is emulated by ALSA
Date: Sun, 6 Apr 2003 14:05:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304061403380.2574-100000@pnote.perex-int.cz>
References: <200304051821.19599.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304051821.19599.c.esken@cityweb.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Esken <c.esken@cityweb.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Apr 2003, Christian Esken wrote:

> Hi,
> 
> my mixer (kmix) supports OSS and ALSA at the same time. This is good for a 
> mixed-mode environment (e.g. if there is a TV card w/o ALSA support).
> 
> Unfortunately this means that kmix finds some mixers twice.
> - One time the real thing (ALSA)
> - One time the OSS-emulation
> 
> This will confuse users.
> 
> Is there any way to find out those OSS mixers which are just emulated?
> I browsed http://www.alsa-project.org/~iwai/OSS-Emulation.html and other 
> documentation but found nothing . I also tried to build the docs below 
> alsa-doc/lib, but failed (Yes, I have openjade installed). 

ALSA emulation layer always report the version of OSS mixer (OSS_GETVERSION) as:

#define SNDRV_OSS_VERSION         ((3<<16)|(8<<8)|(1<<4)|(0))      /* 3.8.1a */

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
