From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: A bug or feature in PCM handling or is it really
 meant to be this way?
Date: Wed, 27 Aug 2003 09:56:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308270955260.1958-100000@pnote.perex-int.cz>
References: <200308251449.05449.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308251449.05449.adrian@mcmen.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Aug 2003, Adrian McMenamin wrote:

> I have been working on writing an ALSA driver for the Sega Dreamcast AICA 
> sound system (PCM). But I have noticed that 2.6.0-test2 will not build for 
> PCM unless the OSS PCM emulation is turned on?

The PCM module is also built for any driver which uses it.

> Is that the way it is meant to be? If so, why different options in the kbuild 
> process?

You have to add a new entry for your card to sound/core/Makefile as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
