From: Martin Langer <martin-langer@gmx.de>
Subject: Re: us-122 firwareloader
Date: Tue, 1 Jun 2004 20:09:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040601180918.GB572@tuba.home>
References: <E1BUd3Y-0003tD-KA@sc8-sf-list2.sourceforge.net> <40BB5314.9080404@laposte.net> <20040531171809.GA640@tuba.home> <40BBA2FD.1020309@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <40BBA2FD.1020309@laposte.net>
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

On Mon, May 31, 2004 at 11:26:21PM +0200, JoDaY wrote:
> Martin Langer wrote:
> >On Mon, May 31, 2004 at 05:45:24PM +0200, JoDaY wrote:
> >
> >>Hi all,
> >>
> >>I've 2 install of linux, the first one is the oldest where hotplug
> >>is able to load firmware when I plug a Tascam us-122.
> >>But if I use snd-usb-usx2y.o (seen in depmod), hotplug is not able to 
> >>load the right firmware... The usb led is not lightened :(
> >
> >
> >Sounds like you are using the old tascam-loader instead of usx2yloader. 
> >Have
> >you installed both usx2yloader parts (in alsa-tools and alsa-firmware)?
> >
> 
> You're right, the one which is able to load the firmware and make the 
> LED of the card lighting is an old version.
> 
> I've tried to change it with alsa-tools and alsa-firmware:
> 
> - snd-usb-usx2y module is loading when I plug the us-122 card
> - I can see "Bus 002 Device 008: ID 1604:8007 Tascam US-122 Audio/Midi 
> Interface" with lsusb
> 
> But the usb LED is always off :(

 It's still the tascam loader! Check your hotplug configuration. The file
"tascam_fpga" you're using isn't the one by usx2yloader. You can remove the
old tascam-loader stuff there. The file "tascam_fpga" from tascam-loader was
different and it's no longer compatible with ALSA from today.

> Is the LED off normal ? 

It goes 'ON' after the second firmware upload. tascam_fpga in the hotplug
directory starts usx2yloader for this job.


martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
