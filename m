From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Tue, 12 Apr 2016 23:25:34 +0900
Message-ID: <570D055E.5070401@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant> <20160307012442.6935bc04@kant>
 <56DCEF78.2080107@sakamocchi.jp> <20160307144306.39f60537@kant>
 <56DD8D1B.5040903@sakamocchi.jp> <20160409183427.00a59f1b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 285AF265189
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 16:25:39 +0200 (CEST)
In-Reply-To: <20160409183427.00a59f1b@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

On Apr 10 2016 01:34, Stefan Richter wrote:
> On Mar 07 Takashi Sakamoto wrote:
>> On Mar 7 2016 22:43, Stefan Richter wrote:
>>> On Mar 07 Takashi Sakamoto wrote:
>>>>   * Dice II units
>>>>    * TC Electronic ImpactTwin
>>>>    * TC Electronic Konnekt24D
>>>>    * TC Electronic Konnekt8
>>>> * Dice Jr. units
>>>>    * TC Electronic DesktopKonnect6
>>>> * Dice Mini units
>>>>    * Focusrite Saffire Pro 26  
>>>
>>> FWIW, Saffire PRO 24 and 40 are based on Dice Junior according to FFADO's
>>> device database.  If desired I could open up my 24 and 40 to check.  
>>
>> If you don't mind it, please.
>> (Because once opening your unit, usually, you cannot get repair service
>> from sellers.)
>>
>> And I wrote wrong for Dice Jr./Mini units. Correctly:
>>  * Dice Jr. units
>>   * TC Electronic DesktopKonnect6
>>   * Focusrite Saffire Pro 26
>>  * I have no units with Dice Mini (Oh...).
>>
>> Anyway, all of my units with Dice Jr. works fine. So we can judge that
>> Pro 40 has its own quirk which we don't know.
> 
> Written on the Dice chip in my Saffire PRO 24, purchased in 2010:
> 
> 	TCD2210
> 	K34FAAB
> 	C0906
> 
> So that's a DICE Mini.
> 
> And the Saffire PRO 40, purchased in early 2015:
> 
> 	TCD2220
> 	K8GVUF
> 	A1246
> 
> i.e. DICE JR.

Thanks for your confirmation. The database of FFADO project includes the
wrongs for some models, therefore it's better for us to get such evidences.

Recently I got PreSonus FireStudio Mobile from used-market. It has
TCD2210 (Dice Mini). I've started to read packet dumps for Dice ASICs
except for TCD3070-CH, on Windows/Linux (ALSA).


Well, would you please get packet dumps with your models? Especially
with SaffirePro 40 because current ALSA firewire stack cannot make it
generate correct sounds, as long as you tested. I need the dumps under
conditions below:

- From the beginning of starting packet streaming.
- During seven seconds after the beginning, at least.
- Including the contents of asynchronous packets for cycle start packet.
- Including the contents of isochronous packets for all of used
channels. At least:
 - The length of payload.
 - The number of channel
 - The node IDs for ishcchronous source and destination
 - Two quadlets of CIP header.
- A condition that your unit is driven by Windows driver.
- At both of 44.1/48.0kHz


For example, this is a sample got by my protocol analyzer (not nosy, I
have no cards with PCILynx).

rel. time (uSec),type,source ID,dest. ID,offset,label,retry
code,response code,priority,data length,quadlet
data,tag,channel,sync.,speed,acknowledge,data
0.000,CycleStart,0xFFC2,0xFFFF,0xFFFFF0000200,0,retry_1,,15,,0xE371B034,,,,100,,
2.614,Streaming,,,,,,,,8,,1,0,0,400,,0x020F0028,0x9001FFFF,0x570A5DF9
122.375,CycleStart,0xFFC2,0xFFFF,0xFFFFF0000200,0,retry_1,,15,,0xE371C034,,,,100,,
2.614,Streaming,,,,,,,,488,,1,0,0,400,,0x020F0028,0x9001DAB9, (CIP data)
122.386,CycleStart,0xFFC2,0xFFFF,0xFFFFF0000200,0,retry_1,,15,,0xE371D034,,,,100,,
2.614,Streaming,,,,,,,,488,,1,0,0,400,,0x020F0030,0x9001F423, (CIP data)
122.386,CycleStart,0xFFC2,0xFFFF,0xFFFFF0000200,0,retry_1,,15,,0xE371E034,,,,100,,
2.614,Streaming,,,,,,,,8,,1,0,0,400,,0x020F0038,0x9001FFFF,0xD4D853F5
122.386,CycleStart,0xFFC2,0xFFFF,0xFFFFF0000200,0,retry_1,,15,,0xE371F034,,,,100,,
2.614,Streaming,,,,,,,,488,,1,0,0,400,,0x020F0038,0x9001098E, (CIP data)
...

When I run my parser written by Python3, I got enough information:
['0xE371B034', '0x020F0028', '0x9001FFFF', 2795258932, 0, 0]
['0xE371C034', '0x020F0028', '0x9001DAB9', 2795262004, 2795267769, 5765]
['0xE371D034', '0x020F0030', '0x9001F423', 2795265076, 2795272227, 7151,
4458]
['0xE371E034', '0x020F0038', '0x9001FFFF', 2795268148, 0, 0]
['0xE371F034', '0x020F0038', '0x9001098E', 2795271220, 2795276686, 5466,
4459]
...

Legend:
 - CycleStart
 - CIP header 0
 - CIP header 1
 - CycleStart(tick)
 - presentation timestamp(tick)
 - subtraction between CycleStart and presentation timestamp (tick)
 - subtraction between previous/current presentation timestamp(tick)

Currently, I can find some differences between Dice ASICs:
 - The ASIC for Dice II transfers/receives packets with less
   transfer-delay than the value defined in IEC 61883-6. But packets
   for the other ASICs are compliant to it.

I don't investigate the sequence of the length of CIP data yet.


Regards

Takashi Sakamoto
