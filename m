From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Patch,
Date: Mon, 22 Nov 2004 07:37:34 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411220737210.2177@pnote.perex-int.cz>
References: <7979.1101081531@www9.gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7979.1101081531@www9.gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andreas Fenkart <afenkart@gmx.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Nov 2004, Andreas Fenkart wrote:

> Hi list
> 
> My gnomemeeting hung when accessing the microphone.
> The problem was that the rate variable was not initialized when jumping to
> the __partial label.

Oops. Thanks. Applied to CVS.
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
