From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Sat, 09 Nov 2013 00:13:14 +0200
Message-ID: <527D61FA.7010903@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>	
 <1380870371.875.14.camel@Wailaba2> <524F51C6.7050203@iki.fi>	
 <1381031338.10109.2.camel@Wailaba2> <5251528B.4010506@iki.fi>	
 <1381293134.845.4.camel@Wailaba2> <52696FB4.1090704@iki.fi>	
 <1383859222.6455.28.camel@Wailaba2> <527CBA83.4000408@iki.fi>
 <1383929090.6455.44.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id ED924265750
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 23:13:18 +0100 (CET)
In-Reply-To: <1383929090.6455.44.camel@Wailaba2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Langlois <olivier@trillion01.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

08.11.2013 18:44, Olivier Langlois kirjoitti:
> 
>>>> No need to go to extraordinary lengths to get it, though :)
>>>>
>>> Anssi,
>>>
>>> Here is the EDID from Xorg.0.log:
>>>
>>> [511268.796] (II) fglrx(0): EDID (in hex):
>>> [511268.797] (II) fglrx(0):     00ffffffffffff00412f000001010101
>>> [511268.797] (II) fglrx(0):     00110103806e3e782ad7b3ae51509423
>>> [511268.797] (II) fglrx(0):     0c4a4721080081800101010101010101
>>> [511268.797] (II) fglrx(0):     010101010101023a801871382d40582c
>>> [511268.797] (II) fglrx(0):     45004e6c4200001e011d8018711c1620
>>> [511268.797] (II) fglrx(0):     582c25004e6c4200009e000000fd0017
>>> [511268.797] (II) fglrx(0):     3d0f450f000a202020202020000000fc
>>> [511268.797] (II) fglrx(0):     0053432d303954580a202020202001c4
>>>
>>> I'm seeing the monitor_name ok. Unfortunately, it doesn't dump the
>>> extension that byte 126 indicates to be present. (the CEA EDID Timing
>>> Extension with the SADs ?) to validate the rest of the content
>>> of /proc/asound/cardX/eld#0.0.
>>>
>>> Is there any other way to get the EDID data?
>>
>> With direct VBE BIOS calls, e.g. with this:
>> http://gitweb.mageia.org/software/monitor-edid/
>>
>> monitor-get-edid -v --try-in-console --max-vbe-port 6 > edid.bin
>> (or --vbe-port X if multiple monitors)
>>
>> or directly with the C tool (X=0..6):
>> monitor-get-edid-using-vbe -v --try-in-console --port X > edid.bin
>>
>> However, I don't know if fglrx interferes with it (I know nvidia
>> proprietary driver doesn't/didn't).
>>
> No luck. This gives me the same info:
> 
> lano1106@whippet2 ~/dev/monitor-edid :( $
> sudo ./monitor-get-edid-using-vbe -v --try-in-console > edid.bin
> [sudo] password for lano1106: 
> VBE version: 3.0, oem version = 15.25
> Memory: 16384k
> OEM name: 
> Vendor name: 
> Product name: 
> Product revision: 
> Port 0:
>   DDC1 not supported
>   DDC2 supported
>   Screen not blanked during data transfer
>   Time to transfer one EDID block: 1 sec (rounded up)
> EDID: Extension block 1 is identical to main EDID block, stopping
> retrieval
> lano1106@whippet2 ~/dev/monitor-edid $ hexdump edid.bin 
> 0000000 ff00 ffff ffff 00ff 2f41 0000 0101 0101
> 0000010 1100 0301 6e80 783e d72a aeb3 5051 2394
> 0000020 4a0c 2147 0008 8081 0101 0101 0101 0101
> 0000030 0101 0101 0101 3a02 1880 3871 402d 2c58
> 0000040 0045 6c4e 0042 1e00 1d01 1880 1c71 2016
> 0000050 2c58 0025 6c4e 0042 9e00 0000 fd00 1700
> 0000060 0f3d 0f45 0a00 2020 2020 2020 0000 fc00
> 0000070 5300 2d43 3930 5854 200a 2020 2020 c401
> 0000080
> 
> My receiver is maybe too old for CEA ext v3 with SADs. I bought it in
> 2008 and maybe it has been manufactured in 2007. It is a Pioneer.

It clearly does have them, since the eld#x contents you provided earlier
contained information from SADs.

Anyway, the information looked correct, so I think we can leave this be :)

-- 
Anssi Hannula
