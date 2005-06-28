From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:   errors when
 installing au8820 modules
Date: Tue, 28 Jun 2005 15:50:54 +0800
Message-ID: <42C1015E.9010201@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de> <42A5D3C8.1030903@mail.ru> <42A6E5BE.4030003@netvigator.com> <42A73305.9000000@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A73305.9000000@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Igor Kovalenko wrote:
> Raymond wrote:
>>Igor Kovalenko wrote:
>>
>>>Well, I've not stated the problem clearly enough.
>>>Once set, volume stays as it should. The problem is that
>>>PCM volume is:
>>>1% - at lowest audible level
>>>25% - at about 50% audible level
>>>49% - at about max audible level
>>>51% - at lowest audible level
>>>75% - at about 50% audible level
>>>99% - at about max audible level
>>>- that is what I described as low-high-low-high.
>>>On the other hand, Master volume behaves as expected.
>>
>>
>>
>>What is the value of comment.range of 'PCM Playback Volume' in
>>/etc/asound.state for your STAC9704 (au8820) ?
>>
>>
>>According to 9704SPEC.pdf, it should be '0-31' ( 5 bits ) for STAC9704
>>PCM Out volume.
>>
> 
> 
>         control.21 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 63'
>                 iface MIXER
>                 name 'PCM Playback Volume'
>                 value.0 21
>                 value.1 21
>         }
> 
> Do you mean AC97 is incorrectly reporting 0...63 range?
> 
> 

Try the following patch to log the read/write of ac97 and post the
system log using dmesg. (loading au8820 and alsactl restore)


alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_core.c
@@ -2520,6 +2515,7 @@
  	vortex_t *card = (vortex_t *) codec->private_data;
  	unsigned int lifeboat = 0;

+	printk(KERN_INFO "ac97 write %.2x : %.4x\n",addr,data);
  	/* wait for transactions to clear */
  	while (!(hwread(card->mmio, VORTEX_CODEC_CTRL) & 0x100)) {
  		udelay(100);
@@ -2567,6 +2563,7 @@
  		}
  	} while ((data & VORTEX_CODEC_ADDMASK) !=
  		 (addr << VORTEX_CODEC_ADDSHIFT));
+	printk(KERN_INFO "ac97 read  %.2x : %.4x\n",addr,data &
VORTEX_CODEC_DATMASK);

  	/* return data. */
  	return (u16) (data & VORTEX_CODEC_DATMASK);



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
