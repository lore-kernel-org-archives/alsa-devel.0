From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Mon, 7 Mar 2016 23:19:38 +0900
Message-ID: <56DD8DFA.8070804@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant> <20160307012442.6935bc04@kant>
 <56DCEF78.2080107@sakamocchi.jp> <20160307144306.39f60537@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F36D261555
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 15:19:44 +0100 (CET)
In-Reply-To: <20160307144306.39f60537@kant>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mar 7 2016 22:43, Stefan Richter wrote:
> On Mar 07 Takashi Sakamoto wrote:
>> Thanks for your report. Totally:
>>   * The patched snd-dice still works fine with Saffire Pro 24.
>>   * The pached snd-dice successfully manages several isochronous streams
>>     without code bugs (i.e. kernel NULL pointer dereference or
>>     continuous locking) with Saffire Pro 24/40.
>>   * The pached snd-dice still has mute issue with Saffire Pro 40.
> 
> I concur.  While I was only able to perform just a few tests yet, there
> doesn't appear to be any regression, and this patchset adds support for
> the previously inaccessible channels at the second transmitter and
> receiver.
> 
>> Anyway, the result cannot block applying this patchset for 4.6. I'll 
>> post it in this night for merging.
> 
> Thanks.

I posted. Thanks for your test ;)

>> Well, about the mute issue, I have no idea to fix it at all. At least, 
>> for my test units, the patched snd-dice works fine without such issues. 
>> Therefore, it's nearly model-dependent issue and I have no way to do for 
>> it. FYI, I tested with:
>>   * OHCI 1394 host controllers
>>    * VIA VT6315
>>    * TI XIO2213
>>   * Dice II units
>>    * TC Electronic ImpactTwin
>>    * TC Electronic Konnekt24D
>>    * TC Electronic Konnekt8
>> * Dice Jr. units
>>    * TC Electronic DesktopKonnect6
>> * Dice Mini units
>>    * Focusrite Saffire Pro 26
> 
> FWIW, Saffire PRO 24 and 40 are based on Dice Junior according to FFADO's
> device database.  If desired I could open up my 24 and 40 to check.

If you don't mind it, please.
(Because once opening your unit, usually, you cannot get repair service
from sellers.)

And I wrote wrong for Dice Jr./Mini units. Correctly:
 * Dice Jr. units
  * TC Electronic DesktopKonnect6
  * Focusrite Saffire Pro 26
 * I have no units with Dice Mini (Oh...).

Anyway, all of my units with Dice Jr. works fine. So we can judge that
Pro 40 has its own quirk which we don't know.

> Furthermore FYI, the FFADO userspace streaming driver has got the following
> two known issues with the PRO 40:
> 	http://subversion.ffado.org/ticket/326
> 	playback at 96 kHz is choppy (but fine at 44.1, 48, 88.2 kHz;
>         reproduced by multiple users, 100% reproducible by myself too)
> 	http://subversion.ffado.org/ticket/372
> 	MIDI playback problem (perhaps dependent on firmware revision;
>         cannot reproduce this myself due to lack of MIDI equipment)

Hm. With a lack of something like packet dump or detailed
case-investigation, I can do nothing for the unit. I have no fashion to
lost my time for meaningless talks, sorry.


For our information, I put your result of hinawa-dice-common-cui from
Saffire Pro 40. (meaningless lines are omitted.)

$ ./hinawa-dice-common-cui 00130e040140dd28 current-status
owner address: ffc1000100000000
global enabled: False
clock status:
  locked: 1
  nominal: 48000
clock source detection:
  locked:
  slip:
measured rate: 48000
dice version: 1.0.12.0
latest notification: 0x00000010
clock source: Internal
sampling rate: 48000
nickname: Pro40-00dd28
Transmitted streams:
  Stream 0:
    iso-channel: 4294967295
    speed:       2
    pcm:         10
    midi:        1
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         IP 1
      1:         IP 2
      2:         IP 3
      3:         IP 4
      4:         IP 5
      5:         IP 6
      6:         IP 7
      7:         IP 8
      8:         SPDIF L
      9:         SPDIF R
  Stream 1:
    iso-channel: 4294967295
    speed:       2
    pcm:         10
    midi:        0
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         ADAT 1
      1:         ADAT 2
      2:         ADAT 3
      3:         ADAT 4
      4:         ADAT 5
      5:         ADAT 6
      6:         ADAT 7
      7:         ADAT 8
      8:         Loop 1
      9:         Loop 2
Received streams:
  Stream 0:
    iso-channel: 4294967295
    start:       0
    pcm:         12
    midi:        1
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         Mon 1
      1:         Mon 2
      2:         Line 3
      3:         Line 4
      4:         Line 5
      5:         Line 6
      6:         Line 7
      7:         Line 8
      8:         Line 9
      9:         Line 10
      10:         SPDIF L
      11:         SPDIF R
  Stream 1:
    iso-channel: 4294967295
    start:       0
    pcm:         8
    midi:        0
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         ADAT 1
      1:         ADAT 2
      2:         ADAT 3
      3:         ADAT 4
      4:         ADAT 5
      5:         ADAT 6
      6:         ADAT 7
      7:         ADAT 8
Synchronization infomation:
  clock-source:  Internal
  locked:        1
  sampling-rate: 48000
    ADAT:
      data-bits: 0
      no-data:   1

$ ./hinawa-dice-common-cui 00130e040140dd28 sampling-rate set 96000

$ ./hinawa-dice-common-cui 00130e040140dd28 current-status
owner address: ffc1000100000000
global enabled: False
clock status:
  locked: 1
  nominal: 96000
clock source detection:
  locked:
  slip:
measured rate: 96000
dice version: 1.0.12.0
latest notification: 0x00000010
clock source: Internal
sampling rate: 96000
nickname: Pro40-00dd28
Transmitted streams:
  Stream 0:
    iso-channel: 4294967295
    speed:       2
    pcm:         16
    midi:        1
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         IP 1
      1:         IP 2
      2:         IP 3
      3:         IP 4
      4:         IP 5
      5:         IP 6
      6:         IP 7
      7:         IP 8
      8:         SPDIF L
      9:         SPDIF R
      10:         ADAT 1
      11:         ADAT 2
      12:         ADAT 3
      13:         ADAT 4
      14:         Loop 1
      15:         Loop 2
Received streams:
  Stream 0:
    iso-channel: 4294967295
    start:       0
    pcm:         16
    midi:        1
    iec60958:
      caps:      0
      enable:    0
    formation:
      0:         Mon 1
      1:         Mon 2
      2:         Line 3
      3:         Line 4
      4:         Line 5
      5:         Line 6
      6:         Line 7
      7:         Line 8
      8:         Line 9
      9:         Line 10
      10:         SPDIF L
      11:         SPDIF R
      12:         ADAT 1
      13:         ADAT 2
      14:         ADAT 3
      15:         ADAT 4
Synchronization infomation:
  clock-source:  Internal
  locked:        1
  sampling-rate: 96000
    ADAT:
      data-bits: 0
      no-data:   1


Regards

Takashi Sakamoto
