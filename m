From: Julian Margetson <runaway@candw.ms>
Subject: Re: Issues with ALSA:ice1724 sound cards on powerpc
 machines
Date: Mon, 11 Apr 2016 13:32:59 -0400
Message-ID: <570BDFCB.20601@candw.ms>
References: <56C4BC13.2010306@candw.ms> <5702C756.1050904@candw.ms>
 <s5hy48k2q26.wl-tiwai@suse.de> <570BB84A.9040400@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp754.redcondor.net (smtp754.redcondor.net [208.80.206.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D963B2608CF
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 19:36:20 +0200 (CEST)
In-Reply-To: <570BB84A.9040400@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/11/2016 10:44 AM, Pavel Hofman wrote:
> Dne 11.4.2016 v 16:11 Takashi Iwai napsal(a):
>> On Mon, 04 Apr 2016 21:58:14 +0200,
>> Julian Margetson wrote:
>>>
>>> On 2/17/2016 2:29 PM, Julian Margetson wrote:
>>>> Hi
>>>>
>>>> Having an issue issue with ice1724 sound cards on powerpc 
>>>> motherboards.
>>>> Motherboards in question Acube Sam460ex .
>>>> The card appears as a valid device but there is no sound output on the
>>>> majority of boots of the computer.
>>>> Logs attached.
>>>> On the first set boot audio playback produced sound ok.
>>>> On the second set boot no sound was produce with audio playback
>>>>
>>>>
>>>> Regards
>>>> Julian Margetson
>>>>
>>>>
>>>>
>>> Anyone have any ideas ?
>>>
>>> Resubmitting again with links to logs instead of included as 
>>> attachments.
>>> The issue also seen on A-Eon Cyrus P5020 motherboard .
>>>
>>> https://www.dropbox.com/s/72labcje9z1r1b7/1alsa-info.txt.7CLHMG0Gap?dl=0 
>>>
>>> https://www.dropbox.com/s/v1pn5kjqrvwu16f/boot_1.log?dl=0
>>> https://www.dropbox.com/s/uuaa14rkpmmz1o0/2alsa-info.txt.VKiEVuytiJ?dl=0 
>>>
>>> https://www.dropbox.com/s/wwu2f5t93l8g26d/boot_2.log?dl=0
>>
>> I have no concrete idea, but in general, the usual problems on PPC are
>> either related with cache coherency or byte endianness.  I don't know
>> of any issue with the latter in ice1724 driver, so likely it's the
>> former.
>>
>
> Perhaps the ice1724 driver was not even tested properly with the AC97 
> codec. Do we know of any separate PCI ice1724 card with this codec?
>
> Regards,
>
> Pavel Hofman.
>
>
The second board mentioned , the Aeon Cyrus ,uses a P5020 so is cache 
coherent .
The problem may be in the initialization of the sound card as on some 
boots with my board , an Acube Sam460ex, it works perfectly.  I have  
tested a CMI8738 pciex1 sound card which works perfectly as do USB cm108 
based external cards .

I also have a PCI ice1724 version of the card  (never used in this 
machine) as well as 2 different pciex1  ice1724 cards with the codec .
The Sam460ex only has 1 pci slot normally used for the SATA card and 1 
shared pcie or SATA II.
I could test with  the pci card by booting from USB .
So either configure as 1 pciex1 slot or 1 on board SATA II .
I am helping to test the onboard sata-dwc but am happy to test any ideas 
for a solution to the audio issues as well.
Will mean reconfiguring my machine back an forth but worth it for 
solutions in both areas .

Regards
Julian
