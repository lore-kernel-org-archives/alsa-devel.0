From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: asoundrc problem
Date: Mon, 27 Jan 2003 17:06:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301271705540.1279-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0301271655520.26601-100000@rzstud3.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301271655520.26601-100000@rzstud3.stud.uni-karlsruhe.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Jan 2003, Oliver Schrempf wrote:

> On Mon, 27 Jan 2003, Takashi Iwai wrote:
> 
> 
> > > Broken configuration: no configurations available: Invalid argument
> >
> > doesn't it work with the pcm "plug:multi" ?
> 
> Sorry, but I can't find any documentation on "plug:multi"?
> How do I have to to use it?

aplay -Dplug:multi

It's device description/name for alsa-lib.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
