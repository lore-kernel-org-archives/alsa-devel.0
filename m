From: Justin Cormack <justin@street-vision.com>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: 17 Nov 2003 12:57:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069073858.1690.31.camel@barbounia>
References: <3FB25EC4.7040607@emt.iis.fhg.de>
	<1068750901.22388.1.camel@barbounia>  <3FB8C2D1.5010603@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FB8C2D1.5010603@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Dausel <dauselm@emt.iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-11-17 at 12:45, Martin Dausel wrote:
> Justin Cormack wrote:
> > On Wed, 2003-11-12 at 16:24, Martin Dausel wrote:
> > 
> >>Hi,
> >>it seems to me that with alsa 0.9.8 drivers it's not possible to load
> >>snd-rme9652. With 0.9.7c there is no problem. The snd-hdsp driver works
> >>in both versions (i tried both cards with both alsa versions).
> >>
> >>error message:
> >>modprobe snd-rme9652
> >>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: init_module:
> >>No such device
> >>modprobe: insmod
> >>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o failed
> >>modprobe: insmod snd-rme9652 failed
> >>
> >>Has anybody similar problems?
> > 
> > 
> > did snd_page_alloc load? This failing because it cannot find enough
> > memory gives this error. Try loading snd_page_alloc early in the boot
> > process (in /etc/rc.sysinit say).
> > 
> > Justin
> > 
> > 
> thanks for your suggestion but i know this problem/solution and tried 
> it, but it doesn't fix my described problem.

what does /var/log/messages say? It should give more detail.

Justin




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
