From: Martin Dausel <dauselm@emt.iis.fhg.de>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: Mon, 17 Nov 2003 13:45:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB8C2D1.5010603@emt.iis.fhg.de>
References: <3FB25EC4.7040607@emt.iis.fhg.de> <1068750901.22388.1.camel@barbounia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1068750901.22388.1.camel@barbounia>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Justin Cormack wrote:
> On Wed, 2003-11-12 at 16:24, Martin Dausel wrote:
> 
>>Hi,
>>it seems to me that with alsa 0.9.8 drivers it's not possible to load
>>snd-rme9652. With 0.9.7c there is no problem. The snd-hdsp driver works
>>in both versions (i tried both cards with both alsa versions).
>>
>>error message:
>>modprobe snd-rme9652
>>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: init_module:
>>No such device
>>modprobe: insmod
>>/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o failed
>>modprobe: insmod snd-rme9652 failed
>>
>>Has anybody similar problems?
> 
> 
> did snd_page_alloc load? This failing because it cannot find enough
> memory gives this error. Try loading snd_page_alloc early in the boot
> process (in /etc/rc.sysinit say).
> 
> Justin
> 
> 
thanks for your suggestion but i know this problem/solution and tried 
it, but it doesn't fix my described problem.

martin




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
