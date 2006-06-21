From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Update: emu1212m
Date: Wed, 21 Jun 2006 12:58:27 +0100
Message-ID: <44993463.9040600@superbug.co.uk>
References: <44951964.9020509@superbug.co.uk> <4498FBC4.5090900@superbug.co.uk>
	<20060621091447.GW3206@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060621091447.GW3206@master.mivlgu.local>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sergey Vlasov wrote:
> On Wed, Jun 21, 2006 at 08:56:52AM +0100, James Courtier-Dutton wrote:
>   
>> For (1), the FPGA array is filled with 78756 bytes of netlist code.
>> I suppose one could consider this 78756 bytes as firmware.
>> Should this firmware sit somewhere in userspace?
>>     
>
> Probably must, due to license issues :(
>   
Fortunately, licensing is not an issue. They donated the emu1212m card 
to me. I have a signed agreement with them that I can write source code 
for the creative sound cards and publish them as GPL. I just can't 
publish or pass on any documents they might have sent me to help me in 
that task.

>   
>> The trouble is, that if one changes some controls on the device, e.g.
>> switching from SPDIF to ADAT digital outputs, a whole new different
>> firmware image is loaded. So, one has multiple different firmware
>> images, with one swapping between them. Should these firmware images be
>> left in the kernel then, instead of using the userspace firmware api?
>>     
>
> There are some drivers in the kernel which load different firmware images
> in different modes.  E.g., the ipw2200 driver can load ipw2200-bss.fw,
> ipw2200-ibss.fw or ipw2200-sniffer.fw depending on the mode set by
> iwconfig (and can switch between them at runtime).
>
> There is also an option to use a single firmware file consisting of
> multiple parts used for different modes, but this obviously has a higher
> memory overhead.  IMHO this should be used only when there are some
> latency restrictions for switching modes (so that a driver can request all
> firmware parts during initialization and then load different parts without
> waiting for userspace helpers).
>   

Are all those threee fw images loaded into the driver cache memory from 
userspace at modprobe time, or is each one loaded from userspace each 
time a iwconfig mode changes?
I don't yet know how many different images I will have to play with. I 
have so far counted the presence of 2.
Is leaving them cached in driver kernel memory considered bad practice, 
and wasteful of memory space?

James
