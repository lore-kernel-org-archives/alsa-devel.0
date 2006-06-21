From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Update: emu1212m
Date: Wed, 21 Jun 2006 13:01:02 +0100
Message-ID: <449934FE.8070904@superbug.co.uk>
References: <44951964.9020509@superbug.co.uk>	<4498FBC4.5090900@superbug.co.uk>	<20060621091447.GW3206@master.mivlgu.local>
	<s5hirmueqvi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirmueqvi.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Sergey Vlasov <vsu@altlinux.ru>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 21 Jun 2006 13:14:47 +0400,
> Sergey Vlasov wrote:
>   
>>> The trouble is, that if one changes some controls on the device, e.g.
>>> switching from SPDIF to ADAT digital outputs, a whole new different
>>> firmware image is loaded. So, one has multiple different firmware
>>> images, with one swapping between them. Should these firmware images be
>>> left in the kernel then, instead of using the userspace firmware api?
>>>       
>> There are some drivers in the kernel which load different firmware images
>> in different modes.  E.g., the ipw2200 driver can load ipw2200-bss.fw,
>> ipw2200-ibss.fw or ipw2200-sniffer.fw depending on the mode set by
>> iwconfig (and can switch between them at runtime).
>>
>> There is also an option to use a single firmware file consisting of
>> multiple parts used for different modes, but this obviously has a higher
>> memory overhead.  IMHO this should be used only when there are some
>> latency restrictions for switching modes (so that a driver can request all
>> firmware parts during initialization and then load different parts without
>> waiting for userspace helpers).
>>     
>
> Well, from programming perspective, keeping all firmware images
> would be easier, so I would implement the cached images at first.
> In addition, these images are also useful to implement
> suspend/resume.
>
>
> Takashi
>   

Ok, but if I am going to cache the images, I might as well just include 
them in the driver .c code. The space taken up will be the same.
I suppose the advantage of using the cache, it that the images are then 
only loaded for the card variants that need it. I.e. loaded for 
emu1212m, but not loaded to Audigy2.

James
