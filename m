From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Sun, 31 Aug 2003 11:32:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030831093237.GB921@tuba.home>
References: <200308282352.54486.annabellesgarden@yahoo.de> <200308292159.13652.plcl@telefonica.net> <20030829235510.GA897@tuba.home> <200308310027.42281.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200308310027.42281.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Martin Langer <martin-langer@gmx.de>, Karsten Wiese <annabellesgarden@yahoo.de>, usb-midi-fw-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 31, 2003 at 12:27:42AM +0200, Pedro Lopez-Cabanillas wrote:
> 
> Yes, but it is easier to use the vendor and product id instead of usb dev full 
> path. Something like this:
> pre-install snd-usb-us122 /usr/sbin/rbtload -P0x8007 -V0x1604 -p71 -Ius122.rbt
> See the attached patch (untested).
> 
> Yes again, and it is the same with post-install of course.
> For USB devices on Linux, there is only a way to handle every event when you 
> plug and unplug a device: hotplug.
> 

But it fails in case of one device if you do a re-plugin! The first plugin
loads the firmware fine. Then you unplug your device and the module still
remains in a status of sleep. If you plug in your device again it woke up,
but it won't get a download of firmware and I don't saw a hotplug event in the
logfile. I believe here is a solution in the ALSA USB corner neccessary. The
download can not start by a hotplug event in this case! (My LEDs are still
dark here!)

martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
