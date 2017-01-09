From: Allan Klinbail <aklinbail@gmail.com>
Subject: additional high input device for snd-dice (A&H Zed R16)
Date: Mon, 09 Jan 2017 06:59:52 +0000
Message-ID: <CA+aoAJfjN83TdDdQnA05KmQs29UiLSQNkdV7OvLsf7S7vQgi+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 20B25266619
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 08:00:03 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id a197so88512051wmd.0
 for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2017 23:00:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I noticed on the changelog that some devices are able to access all
channels without doing any .asoundrc funkiness. Form 4.6 kernel onwards


   - Add support for previously unavailable higher PCM channels on certain
   devices with high channel count, notably Focusrite Saffire PRO 40,
   Focusrite Liquid Saffire 56, and TC Electronic Studio Konnekt 48. These
   devices spread the PCM and MIDI channels across 2 tx + 2 rx IEEE 1394
   channels instead of just 1 tx + 1 rx IEEE 1394 channel, as most other
   devices do.


Pretty sure I've tested with 4.6 and wasn't able to achieve this with my
device.  But can test again with 4.8 if I am wrong.

My device is an Allen and Heath Zed R16..
While latency performance in the way ALSA works is not satisfactory  for my
usage others may wish to use this device with ALSA for simplicity. (remove
the need for FFADO entirely as there is no software mixer for this device
and remove the need for any MIDI bridge)

Currently under ALSA in 44.1k or 48k the device has 16 inputs and 16
outputs on the first firewire channel, and then and additional 10 ins and
10 outs on the second.

If this is any help, here is the vendor info, as used by FFADO


{ # Allen and Heath Zed R16.  Information from Brendan Pike.
    vendorid    = 0x000004C4;
    modelid     = 0x00000000;
    vendorname  = "Allen and Heath";
    modelname   = "Zed R16";
    driver      = "DICE";
    mixer       = "Generic_Dice_EAP";
}


On that latency topic- just voicing my opinion and I don't expect change.

When the paradigm of using periods/frames and buffers is common across all
OS and driver platforms, I don't believe that the driver should force
developers to implement a new method, even if there are better ways of
doing things. That might be okay for small open source projects, but bigger
commercial applications would not be likely to maintain separate
configuration options for Linux, they are more likely to drop Linux
altogether if forced to adopt
 I also know that Takashi S, does not agree but as FFADO devs have agreed
to keep the driver in FFADO I don't mind..
