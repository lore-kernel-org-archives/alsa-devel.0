From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] envy24control.[ch] update for hoontech
 cards.
Date: Sun, 15 Dec 2002 18:23:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212151822540.818-100000@pnote.perex-int.cz>
References: <20021214150508.153E13BB3@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021214150508.153E13BB3@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Henry Walpool <apkennedy@firstlinux.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 14 Dec 2002, Henry Walpool wrote:

> Added some code to block out the error messages for the hoontech cards
> when someone tries to access the professional/consumer option. I tried
> to get the information from hoontech but no luck. I don't think it would
> be that hard to add the correct code to enable these functions but
> hoontech is not talking unfortunately. Hoontech even stopped responding
> to my e-mails. The last response I got was "e-mail the alsa-developers".
> "They have all the information about hoontech cards already."

The original hoontech cards have hardwired support (in hardware) for 
consumer mode only.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
