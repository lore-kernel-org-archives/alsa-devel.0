From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Fri, 13 May 2005 22:05:47 +0800
Message-ID: <4284B43B.6040309@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <200503301013.30400.alien999999999@users.sourceforge.net> <4269C953.4050504@netvigator.com> <200504230928.06494.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200504230928.06494.alien999999999@users.sourceforge.net>
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

It is abnormal to get the message "vortex: reg error" on your au8810, it 
does not appear in my au8830.

http://savannah.nongnu.org/support/?func=detailitem&item_id=102951

You will need to find out the code which cause "vortex: reg error".

You may try the following:

1) Remove code relating to SPDIF ( only SQ1500 and au8830 has SPDIF )

2) use hwwrite(vortex->mmio, VORTEX_CODEC_EN,
hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC0);

No need to use (EN_CODEC0 | EN_CODEC1 ) since your au8810 only has 
stereo codec.

You can use .openalrc to configure OpenAL to use ALSA

(define devices '(alsa))
(define speaker-num 2)
(define alsa-out-device "hw:0,0")
(define alsa-in-device "hw:0,0")


> 
> 
>>Use alsamixer to find out which ac97 codec on your au8810.
> 
> 
> chip: Wolfson WM9701A
> 
> 
>>Do you have any application using gameport, mpu401 or OSS  ?
> 
> 
> haven't gotten any gameport to work, not on the emu10k1 nor the au8810, never 
> use MPU401 and i use OSS emulation on games like AA, ET, OpenAL...
> 
> 
>>>i've had this major crash below only 3 times; and the logs didn't
>>>detect anything specific at the time. the only thing the logs
>>>mentioned at that time was an ntpd sync going on; so the only thing i
>>>can think of is that at a certain moment when a sync is going on, some
>>>kind of lock is holding cause this to happen... the only thing that i
>>>can do to fix this is reset...
>>
>>Do the log indicate the snd-au8810 is loaded properly ?
> 
> 
> yes of course: it gives
> 
> vortex: reg error
> 
> as always ;-)
> 
> 







-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
