From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: S/PDIF on AD1980 patch
Date: Wed, 19 Feb 2003 02:48:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045651705.3e5360f99b0b5@webmail.namezero.com>
References: <1045510594.3e5139c2531dd@webmail.namezero.com> <s5hisvhh6sd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisvhh6sd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai <tiwai@suse.de>:

> At Mon, 17 Feb 2003 11:36:34 -0800,
> Jaroslaw Sobierski wrote:
> > 
> > OK, here is the unified diff. Two of them actually, i separated the 
> > different options for better clarity.
> ...
> > 
> >    Option 2 : The enumerated (more readable but more code) control
> 
> i took this.  clarity is better, isn't it?

By all means. 

> (btw, you can change enum values via alsamixer, too.)
Really? Well I assumed it would be possible but couldn't figure
out how. And the help feature didn't help much :-)

> 
> ok, i committed to cvs.  please check whether it works for you.
> 
I will this evening, had some network problems yesterday.

> 
> the changes for AD1981A/B are not done yet.
> does anyone have this device?
> 
I know 1981A is installed on a few boards with the 845 chipset,
mainly Fujitsu and AOpen, but probably others too.

Tha 1981B is harder to come by, maybe because it's newer, it's
mostly on Intel boards (with different flavors of the 845 chipset).

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
