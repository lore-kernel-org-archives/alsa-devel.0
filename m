From: Robert Siemer <Robert.Siemer@gmx.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sun, 31 Mar 2002 03:25:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020331032556Y.siemer@panorama.hadiko.de>
References: <20020330202713.GF707@rainbow.internal>
	<20020330225341F.siemer@panorama.hadiko.de>
	<20020331004854.GH707@rainbow.internal>
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020331004854.GH707@rainbow.internal>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: rj@rainbow.in-berlin.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Re!

From: Robert Joop <rj@rainbow.in-berlin.de>
> On 02-03-30 22:53:41 MET, Robert Siemer wrote:

> > pnpdump does find the card and 'kernel isapnp' does not? You have a
> > problem beyound ALSA.

> the line i inserted into
> /usr/src/modules/alsa-driver/cards/card-ad1816a.c is
> 
>         ISAPNP_AD1816A('L','W','C',0x1060,'A','D','S',0x7180,0x7181),
> 
> (but it made no difference).
> any suggestions?

You don't need to try anything with ALSA code, as 'kernel isapnp'
does not find your card.

[pnpdump output]
> # Trying port address 0273

Try isapnp_rdp=0x273 and play with isapnp_reset module parameter.
Look in linux/MAINTAINERS. Search with ISAPNP and maybe PNP for
contacts. I cant help here.


Bye,
	Robert
