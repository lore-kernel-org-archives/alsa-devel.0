From: tom burkart <alsa@aussec.com>
Subject: Re: Oops with snd-ymfpci and ALSA 0.9.3a
Date: Fri, 13 Jun 2003 12:45:05 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306131219530.1133-100000@home.aussec.com>
References: <Pine.LNX.4.44.0306121514010.1795-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306121514010.1795-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Jun 12, Jaroslav Kysela wrote:

> Thanks. Could you try this test patch?
No change.  Didn't check what else is not working...
lspci ...:
07: 82
40: 79 90 ...

/var/log/messages:
kernel: ymfpci: cannot initialize FM OPL3 at 0xff00, skipping...

/proc/ioports:
fefc-feff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
ff00-ff3f : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
  ff00-ff03 : YMFPCI OPL3
  ff20-ff21 : YMFPCI MPU401

/proc/iomem:
efff8000-efffffff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
  efff8000-efffffff : YMFPCI

tom.



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
