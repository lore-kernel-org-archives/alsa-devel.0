From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Survey] headphone <-> master volume swap -- which
 codec chip?
Date: Fri, 24 Jan 2003 12:16:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301241213200.1448-100000@pnote.perex-int.cz>
References: <s5hu1fyyi9a.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1fyyi9a.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Jan 2003, Takashi Iwai wrote:

> Hi all,
> 
> there have been bug-reports regarding to the swapping of headphone
> and master volumes.
> i'd like to ask you to check which AC97 codec chip is used on which
> board (or laptop) if you have such a problem.  if this happens only on
> a certain chip model, we can add a quirk for that.

Takashi, this quirk can be done only by detection of subvendor and 
subsystem from the PCI ID space. It's absolutely irrelevant which AC97 
chip is used. Vendor might wire codec in any way. Also, some codecs may 
swap line-out / headphone out via registers.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
