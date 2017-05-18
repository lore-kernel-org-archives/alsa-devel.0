From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about tsched=0 on PulseAudio
Date: Thu, 18 May 2017 15:34:59 +0900
Message-ID: <66edd12d-8b56-c011-53f6-2937276c7045@sakamocchi.jp>
References: <PS1PR0601MB1978795B8EE52CB3A0253554CA100@PS1PR0601MB1978.apcprd06.prod.outlook.com>
 <PS1PR06MB124156C9F611D96128825A6BADEF0@PS1PR06MB1241.apcprd06.prod.outlook.com>
 <PS1PR06MB1241F6959A19BE376A797FA9ADEF0@PS1PR06MB1241.apcprd06.prod.outlook.com>
 <87vap98ts3.wl%kuninori.morimoto.gx@renesas.com>
 <87r2zx8rgl.wl%kuninori.morimoto.gx@renesas.com>
 <PS1PR0601MB146593D08C0AD21D7D2A12F1C5EC0@PS1PR0601MB1465.apcprd06.prod.outlook.com>
 <PS1PR06MB1241467C302DA407BB614AF8ADED0@PS1PR06MB1241.apcprd06.prod.outlook.com>
 <PS1PR0601MB1465277CACFBC4551F5C7F6CC5ED0@PS1PR0601MB1465.apcprd06.prod.outlook.com>
 <PS1PR06MB1241943FA1439E6AE04286B8ADE20@PS1PR06MB1241.apcprd06.prod.outlook.com>
 <87r2zo49qu.wl%kuninori.morimoto.gx@renesas.com>
 <PS1PR0601MB1465F2D28FAA5D1B13A91A54C5E70@PS1PR0601MB1465.apcprd06.prod.outlook.com>
 <87h90k3t04.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1srneuql.wl-tiwai@suse.de>
 <87wp9eoiq6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 46D53266A4B
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 08:35:01 +0200 (CEST)
In-Reply-To: <87wp9eoiq6.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>, goda <yusuke.goda.sx@renesas.com>, RYO KODAMA <ryo.kodama.vz@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 18 2017 14:12, Kuninori Morimoto wrote:
>> Both information have to be accurate enough.  With tsched=1, the
>> period update is basically ignored and PA tries to update the buffer
>> at its own timing.  The samples to be updated are determined by avail
>> and delay values of snd_pcm_status, which are calculated from hw_ptr,
>> appl_ptr and delay in the kernel.
>>
>> Also, such a problem might be some memory coherency issue.
> 
> OK, thank you for your explanation.
> My current driver updates snd_pcm_ops::pointer only when DMA transfer was
> finished, but I guess it needs to adjust to update it during transfer, too.
> I think I can use dmaengine_tx_status() for this purpose.
> I don't know how to know about delay, but I will try update pointer as 1st step.

If your driver calls 'snd_pcm_period_elapsed()' in any hw/sw IRQ 
context, it's correct. But 'struct snd_pcm_ops.pointer' callback is not 
only executed by the function, but also in the other contexts such as 
ioctl(2) with HWSYNC.

In design of ALSA PCM core, the callback is expected to return the 
number of PCM frames currently transferred via physical audio serial 
bus, inner PCM period boundary. As long as I know, recent hardwares have 
any register for this purpose and your driver could calculate the number.

The 'accuracy' represents how accurate the returned number is, against 
actual transferring via audio serial bus.


Regards

Takashi Sakamoto
