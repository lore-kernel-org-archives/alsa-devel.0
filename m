From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: AC3 Passthru on SB Live
Date: Wed, 27 Feb 2002 17:19:44 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFAEECCCAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h8z9elvmc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Or, it might be the problem of dma mask.  ALSA uses 31bit mask while
> Creative's driver uses 29bit.  But anyway this won't affect unless you
> have more than 512MB RAM and kernel ocasionally allocates the area
> greater than 512MB.
Creative's driver uses 29bit mask, because a 32bit mask was creating
problems with some users.
Maybe the SB Live is only capable of 29bits for DMA.

Cheers
James


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
