From: Benouille <benouille@ifrance.com>
Subject: Re: snd-rme9652 fails
Date: Thu, 18 Dec 2003 09:38:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE1676C.40806@ifrance.com>
References: <3FE02BA2.8020900@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FE02BA2.8020900@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I confirm this fact:
with kernel 2.4.23 and alsa 1.0rc2, the module snd-rme9652 can't be loaded
althought the "old"  rme digi 9652 is perfectly working with alsa 0.9.6

Regards,

Benoit

Le 17/12/2003 11:10, Martin Wilhelm a &eacute;crit :

> Hi,
> 
> 
> according to martin dausel's posting some weeks ago, I can
> confirm, that since alsa-0.9.8 was released, the "old" rme-9652
> cards are no longer working.
> This is very strange, because the driver was not changed... :(
> And: The OSS-kernelmod (rme96xx) works fine!
> 
> Here's some output (long lines not wrapped):
> 
> 
> Alsa-Try:
> ----------------------------------------------------------------
> [root@il028 /]# modprobe snd-rme9652
> /lib/modules/2.4.23-uv1-AEMT/kernel/sound/pci/rme9652/snd-rme9652.o:
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> modprobe: insmod
> /lib/modules/2.4.23-uv1-AEMT/kernel/sound/pci/rme9652/snd-rme9652.o failed
> modprobe: insmod snd-rme9652 failed
> [root@il028 /]#
> 
> [root@il028 /]# dmesg
> RME Digi9652/Digi9636: no cards found
> [root@il028 /]#
> ----------------------------------------------------------------
> 
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
