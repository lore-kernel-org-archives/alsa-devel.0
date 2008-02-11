From: "Matthew R. Hurne" <matt.hurne@versatile.com>
Subject: Re: Intel ICH7/Realtek ALC262 on MSI MS-7290 (Crystal
 945)
Date: Mon, 11 Feb 2008 17:06:53 -0500
Message-ID: <47B0C6FD.2080804@versatile.com>
References: <479770D5.6000501@versatile.com>	<47977134.4000700@versatile.com>	<1201763319.23369.61.camel@razman.gruemaster.com>	<47A21AAD.6000203@versatile.com>	<s5hr6fx2dja.wl%tiwai@suse.de>	<47A73462.5030404@versatile.com>	<s5hve541zar.wl%tiwai@suse.de>
	<47A78ECA.9070805@versatile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C70C24611
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 23:06:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mustang.versatile.com (Postfix) with ESMTP id 125E714C0004
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 17:06:54 -0500 (EST)
Received: from mustang.versatile.com ([127.0.0.1])
	by localhost (mustang.versatile.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id UyUBqNQI2QL9 for <alsa-devel@alsa-project.org>;
	Mon, 11 Feb 2008 17:06:53 -0500 (EST)
Received: from [10.50.10.128] (pedro.ad.versatile.com [10.50.10.128])
	by mustang.versatile.com (Postfix) with ESMTP id 3CDB114C0002
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 17:06:53 -0500 (EST)
In-Reply-To: <47A78ECA.9070805@versatile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Was the output of alsa-info.sh useful for anyone to assist me with this issue?

Matthew R. Hurne wrote:
> Takashi Iwai wrote:
>> At Mon, 04 Feb 2008 10:50:58 -0500,
>> Matthew R. Hurne wrote:
>>> Takashi Iwai wrote:
>>>> At Thu, 31 Jan 2008 13:59:57 -0500,
>>>> Matthew R. Hurne wrote:
>>>>> Tobin Davis wrote:
>>>>>> Sorry for not getting back sooner.   Could you try alsa-1.0.16rc2 with
>>>>>> the following configuration:
>>>>>>
>>>>>>     ./configure --with-cards=hda-intel --with-debug=detect && make &&
>>>>>>     sudo make install
>>>>>>
>>>>>> After it is installed, type "dmesg" and look for the alsa output
>>>>>> (line-outs, speakers, etc).  Copy that into an email and send it to me,
>>>>>> please.
>>>>>>
>>>>>> Tobin
>>>>>>
>>>>> No worries about not getting back sooner - I appreciate you getting back at all!
>>>>>
>>>>> I've done as you requested, and here is the output of dmesg:
>>>>>
>>>>> ALSA /root/alsa-driver-1.0.16rc2/alsa-kernel/pci/hda/hda_intel.c:1788: chipset global capabilities = 0x4401
>>>>> ALSA /root/alsa-driver-1.0.16rc2/alsa-kernel/pci/hda/hda_intel.c:740: codec_mask = 0x1
>>>>> hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
>>>>> ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2863: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)
>>>>> ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2867:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>>>>> ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2871:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
>>>>> ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2872:    mono: mono_out=0x0
>>>> As you see, there is no speaker output defined in the pin default
>>>> config which is set by BIOS.
>>>>
>>>> If you don't get any sound with model=basic even after
>>>> unmuting/adjusting Front, Headphone and Mono volumes/switches, then
>>>> the problem is likely a missing EAPD via COEF comands...
>>>>
>>>>
>>>> Takashi
>>> I don't get any sound with model=basic either (nor with any other model listed for the ALC262).  Unfortunately, I have no idea what "a missing EAPD via COEF commands" means!  :-)  I know Tobin had replied offering to help out with this issue as well - perhaps he'll be able to do something with that?  I'll glady do anything asked of me (that isn't over my head), such as compiling from hg sources with debugging enabled and sending along output, etc.
>> As a first step, upload the alsa-info.sh output with model=basic to
>> double-check whether it's really done properly.
>>
>> You'll have some ideas about EAPD and COEF when you see
>> patch_realtek.c.
>>
>>
>> Takashi
> 
> Attaching alsa-info.txt generated from the latest alsa-info.sh in hg, run as:
> 
> ./alsa-info.sh --no-upload
> 
> Matt
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Matthew Hurne
Versatile Systems, Inc.
717.919.9102
matthew.hurne@versatile.com
