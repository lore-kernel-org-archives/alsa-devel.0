From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: ALSA lib application compatibility [was] Re:
 [Alsa-devel] mixer device
Date: Wed, 19 May 2004 12:27:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405191223280.1778@pnote.perex-int.cz>
References: <1084218706.31496.72.camel@shrek.bitfreak.net>
 <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
 <20040513153457.GE6913@sunrise.pg.gda.pl>  <Pine.LNX.4.58.0405181545510.13943@spring>
  <1084887054.1835.14.camel@localhost>  <s5had053hn2.wl@alsa2.suse.de>
 <1084890225.1835.23.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084890225.1835.23.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 May 2004, Manuel Jander wrote:

> Yes, i think that the hardware constraint scheme of ALSA is very
> powerful, but the problem is that it fails. It would be great if it
> could be mopified to be failproof, that is, allow the application to
> work somehow regardless of what restrictions must be taken.

The simplified parameter initization routine (simple PCM extension) will 
take care about this in alsa-lib. This routine should find the "right" 
period/buffer sizes specified with the requested latency for any hardware.
It is possible that we'll have some workarounds for very specific hardware
there.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
