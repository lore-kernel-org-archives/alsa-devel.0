From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emu10k1 bug and patch (0.9.0rc7)
Date: Thu, 13 Feb 2003 21:30:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302132129000.1315-100000@pnote.perex-int.cz>
References: <20030210172112.GA12226@via.ecp.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030210172112.GA12226@via.ecp.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, bozo@via.ecp.fr
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Feb 2003, Arnaud de Bossoreille de Ribou wrote:

> So the bug looks like a signedness problem since sw_ready is unsigned
> and there is a while(sw_ready > 0), which explain the constant delay,
> next in the "snd_emu10k1_fx8010_playback_transfer" function.
> 
> So the emu10k1.patch file attached fixes the problem and seems not to
> introduce new ones.

Please, could you try this patch, if it also fixes your problem? Thanks.


Index: emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.26
diff -u -r1.26 emufx.c
--- emufx.c	31 Jan 2003 15:21:03 -0000	1.26
+++ emufx.c	13 Feb 2003 20:29:55 -0000
@@ -532,7 +532,7 @@
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
-		pcm->sw_ready += diff;
+		frames += diff;
 	}
 	pcm->sw_ready += frames;
 	pcm->appl_ptr = appl_ptr + frames;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
