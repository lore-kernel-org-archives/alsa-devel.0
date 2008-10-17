From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: New BIOS, new vendor and device IDs
Date: Fri, 17 Oct 2008 09:44:17 -0500
Message-ID: <48F8A4C1.10507@gmail.com>
References: <48F7FDAF.3010300@gmail.com> <s5hbpxjzfuy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D1AEA243A3
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 16:44:45 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so200522yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2008 07:44:27 -0700 (PDT)
In-Reply-To: <s5hbpxjzfuy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Developer Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 16 Oct 2008 21:51:27 -0500,
> Chris Pemberton wrote:
>   
>> My machine is a Lenovo 3000 N100 laptop (0768 model).  I had to recently 
>> update the BIOS.
>>
>> Old BIOS:  lspci -> device id:  [17aa:2066] which is a Realtek ALC861VD 
>> (found in patch_realtek.c)
>>
>> New BIOS: lspci -> device id: [8086:27d8] (found in hda_intel.c)
>>
>> In both cases, I use the module option "model=3stack" to get sound working:
>> Laptop speakers work. 
>> Built-in mic works. 
>> External mic works
>> Headphones work; but automatic speaker muting does not. 
>>     
>
> 3stack model doesn't do auto-muting by design.
> Try without any model option with the latest driver below,
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> If the auto-probing still doesn't work, you can try first model=lenovo.
>
>
> thanks,
>
> Takashi
>
>   
Updated to latest alsa-driver snapshot; configured with full debug support.

Results:
auto-probing:  no sound
model=lenovo:  no sound 
model=3stack:  sound works as described previously (no auto-muting)

Results of alsa-info script (latest driver snapshot):
auto-probe:        
http://www.alsa-project.org/db/?f=66f43ddfdabc4b48b9e5c50f9a792d2fcb775905
model=lenovo:  
http://www.alsa-project.org/db/?f=5e082f9a1361d28c187ae3eba21605de8196e4aa
model=3stack:  
http://www.alsa-project.org/db/?f=410592e40da7324d76a39e1b201beb2436a9a96b

Thanks,

Chris
