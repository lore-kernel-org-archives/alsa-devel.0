From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Lenovo ThinkCentre A58 - surround 5.1 problem
Date: Sat, 2 Feb 2013 09:02:13 +0800
Message-ID: <CAN8cciZZnf634aAvp06ivpKozu-YFj5jRjSufB8hEotzY2ZAaQ@mail.gmail.com>
References: <CAN8cciaBzWWDbAQ-Bbgo_Zkuch_upXqY2ZOiHELtFP9NK581Gw@mail.gmail.com>
 <CAN8ccibCFgdZ+VdKbgJr72511u0pHQ6q63pPy-UmoEnQUY2p8g@mail.gmail.com>
 <CAN8ccib92+8=1t8nhpqkfVAA7QayJQDv16s9yF9WGmB-yGYtAg@mail.gmail.com>
 <CAN8ccibifWvBxf24ooDJPZ4UPpPqoN1==R3SU3cH1Ww0miiFEQ@mail.gmail.com>
 <CAN8ccibn=oV5VdQdAfrTqy9oCw6aZVUW=NoO=u9F+q89oTe-0Q@mail.gmail.com>
 <CAN8ccibfTwamvMRBjh1tJEPnprgkoO-zE-uhwxPbFZBDghkZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9280C265B5F
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2013 02:02:15 +0100 (CET)
Received: by mail-ie0-f171.google.com with SMTP id 10so4057981ied.30
 for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2013 17:02:14 -0800 (PST)
In-Reply-To: <CAN8ccibfTwamvMRBjh1tJEPnprgkoO-zE-uhwxPbFZBDghkZNA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?UsO8ZGk=?= <ruedi@battle-eggs.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I already tried so many options in alsa-mixer - as far as they where
possible to set. As we say im Germany: "I'm out of my latin" ;-)
>
> Any Ideas how to go on?
>
>>  >
>>  > I'm running a Lenovo ThinkCentre A58 with a ALC662 rev. 1 chip on
>> board. The mainboard has 3 jacks at the back of the PC and 2 ones at
>> it's front (mic and headphones).
>>  >
>>  > The problem is, that the connectors are not automatically arranged to
>> playback 5.1 surround sound. I must manually set the "model" to
>> "asusmode4" to get 5.1 and then run a script as root, to set the
>> backside jacks to output and to Center/LFE and rear speaker. Also I have
>> to mute the internal speaker.
>>  >
>>  > I've tried to patch the module manually, but this went wrong somehow.
>> I don't know how to proceed.
>>  >
>>  > So maybe you can help me and I can help you to complete the ALSA code
>> for this special mainboard/PC - hopefully.
>>  >
>>  > So long, I would thank you for your feedback.
>>  >
>>

For a desktop with/without internal speaker, three audio jacks at rear
panel

Green lineout jack , blue and pink jacks should have higher priority to
allocate DAC (audio output node 0x02, 0x03 and 0x04) than the headphone and
the internal speaker to support surround 5.1

This mean that in function parse_output_paths() to prevent the assignment
of dac speaker

-      bool fill_hardwired = true, fill_mio_first = true;
+       bool fill_hardwired = false, fill_mio_first = true;

Or use the existence of internal Mic to determine the value of
fill_hardwired
