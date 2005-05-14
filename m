From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Sat, 14 May 2005 16:12:04 +0800
Message-ID: <4285B2D4.8010506@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <200504230928.06494.alien999999999@users.sourceforge.net> <4284B43B.6040309@netvigator.com> <200505131628.03297.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200505131628.03297.alien999999999@users.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org


Would you post the result of "more
/proc/asound/au8810/codec97#0/ac97#0-0+regs" ?

http://www.wolfsonmicro.com/products/digital_audio/ac97/WM9701/

Unless ALSA mis-identify the AC97 codec on your au8810, WM9701A is a
stereo codec

Do alsamixer or windows driver told you that your card has "4 speakers
mode" or your card has out1,out2 jacks and coaxial SPDIF ?

http://www.watch.impress.co.jp/akiba/hotline/991106/newitem.html#19


EN_CODEC0 - enable the front channels of au88x0 to ac97 codec

EN_CODEC1 - enable the rear channels of au88x0 to ac97 codec



Alien wrote:
> Op vrijdag 13 mei 2005 16:05, schreef Raymond:
> 
>>It is abnormal to get the message "vortex: reg error" on your au8810, it
>>does not appear in my au8830.
>>
>>http://savannah.nongnu.org/support/?func=detailitem&item_id=102951
>>
>>You will need to find out the code which cause "vortex: reg error".
> 
> 
> if i have some time, i will try it...
> 
> 
>>You may try the following:
>>
>>1) Remove code relating to SPDIF ( only SQ1500 and au8830 has SPDIF )
>>
>>2) use hwwrite(vortex->mmio, VORTEX_CODEC_EN,
>>hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC0);
>>
>>No need to use (EN_CODEC0 | EN_CODEC1 ) since your au8810 only has
>>stereo codec.
> 
> 
> you sure about that, the card told me it had stereo and 4 speaker mode? or are 
> we talking about different stuff?
> 
> 
> 
>>>>Use alsamixer to find out which ac97 codec on your au8810.
>>>
>>>chip: Wolfson WM9701A
>>>
>>>











-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
