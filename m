From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: CMI973, patch and alsa release
Date: Mon, 2 Feb 2004 09:06:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402020906160.1872@pnote.perex-int.cz>
References: <401D50B6.9070308@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401D50B6.9070308@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Davodet Olivier <olivier.davodet@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Feb 2004, Davodet Olivier wrote:

> Hello,
> 
> My config :
> 
> Biostar IdeQ 200T with an onboard C-Media CMI9739A 6-Channel AC'97 CODEC
> Mandrake 9.2 : kernel 2.6.1 with alsa 1.0.1
> (kernel-smp-2.6.1.1mdk-1-1mdk) and alsa lib 0.9.6
> 
> I use the snd-intel8x0 module.
> 
> This module does not work very well with this chipset. In fact you can't use
> PCM. When you launch xmms the sound plays but you can't change the
> volume...
> 
> In the alsa-devel mailing-list I found a patch by C.L. Thien (from 
> cmedia) for the alsa 1.0.rc2.
> 
> I updated my kernel source with this patch, recompiled all and installed the
> new sound modules.
> 
> And now all works fine, I can change the sound volume in xmms, mute, unmute,
> all works ok ! (except the known bug with quake 3 : the sound loops when you
> enter in a map and quake3 freezes...)
> 
> Do you think this patch can be included by the alsa team in an official 
> release ?

No. This patch is unacceptable for us.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
