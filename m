From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-ens1371 driver failed assert
Date: Wed, 20 Nov 2002 11:25:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211201125150.1437-100000@pnote.perex-int.cz>
References: <200211192212.26739.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211192212.26739.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Nov 2002, Pedro Lopez-Cabanillas wrote:

> Hi,
> 
> The following lines are from my syslog after "modprobe snd-ens1371" with 
> current CVS alsa drivers:
> 
> PCI: Found IRQ 9 for device 00:11.0
> ALSA ../alsa-kernel/core/control.c:227: BUG? (!(kcontrol->access & (1<<1)) || 
> kcontrol->put != ((void *)0)) (called from ca8f67a6)
> 
> Mixer works, though. (With too much controls, i don't know what they are).

Fixed in CVS. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
