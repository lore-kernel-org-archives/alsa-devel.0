From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 22:27:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302202224410.1266-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0302202156450.17762-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0302202156450.17762-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Feb 2003, tomasz motylewski wrote:

> Do I understand it correctly that the server stores data in 32 bit buffer and
> then puts it in 16 bit DMA buffer of the card? This is one operation more
> compared with mixing directly in DMA buffer.

There is no server and 32-bit buffer is used for total sum of samples from
all clients. Otherwise you'll get saturation errors (wrong clipping) as
described in the previous discussion.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
