From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Waveterminal 192M Envy24HT
Date: Thu, 20 Mar 2003 19:44:35 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303201941540.1318-100000@pnote.perex-int.cz>
References: <200303201834.h2KIYakX063716@mail.mega.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303201834.h2KIYakX063716@mail.mega.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Pouzzner <douzzer@mega.nu>
Cc: "cw@acidtechno.net" <cw@acidtechno.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Mar 2003, Daniel Pouzzner wrote:

> >Is there an authoritative person on vendor data ?
> 
> One would think so, at least de facto - whoever maintains the matrix.
> 
> I emailed perex@suse.cz about the issue but got no response.

Evny24HT chip is supported in our CVS (MidiMan Revolution 7.1 uses this 
chip). I don't know about the specific information for the Waveterminal 
129M soundcard. It is not usually difficult to do the reverse engineering 
and collect a schematic how is the envy chip connected with the I/O chips 
using a simple voltmeter.

I think that the card is green in the matrix, because we have 
documentation for the master (envy) chip.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
