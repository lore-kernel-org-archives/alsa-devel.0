From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: 0x10b9:0x5461 not supported?
Date: Wed, 20 Jul 2005 20:07:17 +0200
Message-ID: <1121882838.2970.1.camel@localhost.localdomain>
References: <Pine.HPX.4.33n.0507201607110.21951-100000@studcom.urz.uni-halle.de>
	 <42DE990A.6020702@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42DE990A.6020702@gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk <noisyb@gmx.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Did you try to add this pci id in pci_device_id azx_ids table in file
hda_intel.c ?

Peter Zubaj

On Wed, 2005-07-20 at 20:33 +0200, Dirk wrote:
> Clemens Ladisch wrote:
> 
> >Dirk wrote:
> >  
> >
> >>http://pciids.sourceforge.net/iii/?i=10b95461
> >>
> >>Doesn't work with snd_hda_intel or anything else I tried...
> >>    
> >>
> >
> >We don't have any documentation for this chip.
> >
> >The CVS version of this driver assumes that this chip is compatible
> >with the Intel HDA controller; please test it.
> >  
> >
> 
> That's exactly what I tried. I also tried the hacked alsa-driver from
> the download pages of Realtek and the Mainboard manufacturer. But
> nothing worked. The driver loads fine but there is no mixer and no sound.
> 
> The mainboard description
> (http://www.asus.com/prog/spec.asp?m=P5RD1-V&langs=01) says it's a
> Realtek ALC 861... but "lspci -n" identifies (0x10b9) ALi and not
> RealTek... :-/
> 
> ALi's site doesn't list this card or chip (I looked for "5461" and
> "M5461") at all. So I guess the mainboard description is right and lspci
> is "wrong"... Dunno..
> 
> Dirk
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
