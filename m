From: Martin Langer <martin-langer@gmx.de>
Subject: Re: us-122 firwareloader
Date: Mon, 31 May 2004 19:18:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040531171809.GA640@tuba.home>
References: <E1BUd3Y-0003tD-KA@sc8-sf-list2.sourceforge.net> <40BB5314.9080404@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <40BB5314.9080404@laposte.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: JoDaY <jo.day@laposte.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2004 at 05:45:24PM +0200, JoDaY wrote:
> Hi all,
> 
> I've 2 install of linux, the first one is the oldest where hotplug
> is able to load firmware when I plug a Tascam us-122.
> But if I use snd-usb-usx2y.o (seen in depmod), hotplug is not able to 
> load the right firmware... The usb led is not lightened :(

Sounds like you are using the old tascam-loader instead of usx2yloader. Have
you installed both usx2yloader parts (in alsa-tools and alsa-firmware)?

> 
> On the other linux, I can't get firmwareloader working...

Where does it hang? Do you already have a renumbered ID? It changes from
8006 to 8007. Check that number with lsusb. Everything installed?
- fxload
- hotplug scripts
- alsa-tools/usx2yloader
- alsa-firmware/usx2yloader

Any output in the logfiles?


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
