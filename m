From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Tue, 13 Sep 2005 20:35:29 +0300
Message-ID: <20050913173529.GD31269@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com>
 <20050906142917.GA30523@sashak.softier1.local>
 <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de>
 <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de>
 <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>
 <20050913085552.GA2655@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050913085552.GA2655@titan.lahn.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

On 10:55 Tue 13 Sep     , Philipp Matthias Hahn wrote:
> 
> See attached tar-file for a full copy of everything under
> /proc/asound/au8810 after applying the attached patch against ASLA from
> linux-2.6.13.1.

ac97#0-N entries are identical there for both codecs, this is because
ac97_codec_read/write always accesses primary codec. Try next patch
please.

Sasha.


--- au88x0_core.c_orig	2005-09-13 20:00:50.000000000 +0300
+++ au88x0_core.c	2005-09-13 20:05:36.000000000 +0300
@@ -2535,7 +2535,8 @@ vortex_codec_write(ac97_t * codec, unsig
 	}
 	/* write register */
 	hwwrite(card->mmio, VORTEX_CODEC_IO,
-		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		(((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		 ((0x80*codec->num) << VORTEX_CODEC_ADDSHIFT)) |
 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
 		VORTEX_CODEC_WRITE);
 
@@ -2560,6 +2561,7 @@ static unsigned short vortex_codec_read(
 	}
 	/* set up read address */
 	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK);
+	read_addr |= (0x80*codec->num) << VORTEX_CODEC_ADDSHIFT ;
 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
 
 	/* wait for address */


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
