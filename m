From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Fri, 27 Mar 2015 13:09:05 +0800
Message-ID: <CAN8cciYbLJHHAKapeVuiuL61wK8bhD9JY0EdF2OWU1gJprq56A@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
 <CAN8cciY7zPaM1kGbky3st_V5G=vg_aeLrm2QrNbpVinYOU=qyA@mail.gmail.com>
 <64443a816660f3098fc300c7d7b5a01f@swn.nu>
 <CAN8cciY-K-FkQp1H6Bj0v51CRHrOyFrJ2=ZaY5YLvkRmNU8TRg@mail.gmail.com>
 <ec6b05bc169224058a4835e2139cbcb4@swn.nu>
 <5514D5DD.1020002@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F85E260698
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 06:09:06 +0100 (CET)
Received: by obcxo2 with SMTP id xo2so14772965obc.0
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 22:09:05 -0700 (PDT)
In-Reply-To: <5514D5DD.1020002@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, nb <nb@dagami.org>, Christian Gleerup <cromozon@swn.nu>
List-Id: alsa-devel@alsa-project.org

>>
>> I have done a couple of things
>> First I left the laptop off with no power connected;
>> This made the laptop awake in the non functional state regarding the
soundcard.
>> I then used this opportunity to update to the latest kernel.
>>
>> With the latest kernel, the sound is still not working.
>> Unmuting the S/PDIF in alsamixer turn on red light in the headphone jack.
>>
>> also, using 3stack-digout option doesn't bring back sound.
>>
>> This is the output from the alsa information tool
>>
http://www.alsa-project.org/db/?f=df46a9ee01e04dde11b194e0278c9f22594540d0
>>
>> after updating this is the output from various commands
>>
>> [
>> Nothing plugged in:
>> ./hdajacksensetest -a
>> Pin 0x14 (Green Headphone, Rear side): present = No
>> Pin 0x15 (Not connected): present = No
>> Pin 0x16 (Not connected): present = No
>> Pin 0x17 (Not connected): present = No
>> Pin 0x18 (Internal Mic): present = Yes
>> Pin 0x19 (Not connected): present = No
>> Pin 0x1a (Not connected): present = Yes
>> Pin 0x1b (Not connected): present = No
>> Pin 0x1c (Not connected): present = No
>> Pin 0x1d (Not connected): present = No
>> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
>> Pin 0x1f (Not connected): present = No
>>
>> ./hda-verb /dev/snd/hwC0D0 0x1{4,5,8} SET_PIN_SENSE 0 nid
>> nid = 0x14, verb = 0x709, param = 0x0
>> value = 0x0
>>
>> nid = 0x15, verb = 0x709, param = 0x0
>> value = 0x0
>>
>> nid = 0x18, verb = 0x709, param = 0x0
>> value = 0x0
>>
>> ./hda-verb /dev/snd/hwC0D0 0x1{4,5,8} GET_PIN_SENSE 0 nid
>> nid = 0x14, verb = 0xf09, param = 0x0
>> value = 0x80001f41
>>
>> nid = 0x15, verb = 0xf09, param = 0x0
>> value = 0x80001f41
>>
>> nid = 0x18, verb = 0xf09, param = 0x0
>> value = 0x7fffffff
>> ]
>>

You need to issue get_pin_sense  after set_pin_sense of the same node to
get the impedance measurement of that node before you test another node

It is strange that your result is different from hdajacksensetest

>> [
>> With headphone plugged in
>> ./hdajacksensetest/hdajacksensetest -a
>> Pin 0x14 (Green Headphone, Rear side): present = No
>> Pin 0x15 (Not connected): present = Yes
>> Pin 0x16 (Not connected): present = No
>> Pin 0x17 (Not connected): present = No
>> Pin 0x18 (Internal Mic): present = Yes
>> Pin 0x19 (Not connected): present = No
>> Pin 0x1a (Not connected): present = Yes
>> Pin 0x1b (Not connected): present = No
>> Pin 0x1c (Not connected): present = No
>> Pin 0x1d (Not connected): present = No
>> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
>> Pin 0x1f (Not connected): present = No
>>
>> // and also ecact same output for hda-verb as with nothing plugged in
>> ]
>>
>> [
>> with Mic plugged in, the following items changed
>>
>> ./hdajacksensetest/hdajacksensetest -a
>> Pin 0x14 (Green Headphone, Rear side): present = Yes
>> Pin 0x15 (Not connected): present = Yes
>> Pin 0x16 (Not connected): present = No
>> Pin 0x17 (Not connected): present = No
>> Pin 0x18 (Internal Mic): present = Yes
>> Pin 0x19 (Not connected): present = No
>> Pin 0x1a (Not connected): present = Yes
>> Pin 0x1b (Not connected): present = No
>> Pin 0x1c (Not connected): present = No
>> Pin 0x1d (Not connected): present = No
>> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
>> Pin 0x1f (Not connected): present = No
>>
>> ./hda-verb /dev/snd/hwC0D0 0x15 GET_PIN_SENSE 0 nid
>> nid = 0x15, verb = 0xf09, param = 0x0
>> value = 0x7fffffff
>>
>> ./hda-verb /dev/snd/hwC0D0 0x18 GET_PIN_SENSE 0 nid
>> nid = 0x18, verb = 0xf09, param = 0x0
>> value = 0x80001f41
>> ]
>>
> It looks like the pin connection map as below:
>
> 0x14: external mic in jack
> 0x15: external headphone jack
> 0x18: internal mic
> 0x1a: internal speaker
> 0x1e: internal SPDIF Out

If sound work with the previous version ,

Either 0x14, 0x15 and 0x16 are the headphone and speaker

So internal mic is 0x1a and mic jack is 0x18 if hda jack sense test report
present when you plug the mic jack

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=29e3fdcc84e5da04cb7e6a36fee0a772c91d3b28

- * ALC880 ASUS model
- *
- * DAC: HP/Front = 0x02 (0x0c), Surr = 0x03 (0x0d), CLFE = 0x04 (0x0e)
- * Pin assignment: HP/Front = 0x14, Surr = 0x15, CLFE = 0x16,
- *  Mic = 0x18, Line = 0x1a
- */
