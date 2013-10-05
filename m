From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Microphone does not longer work on Lenovo N581
Date: Sat, 5 Oct 2013 16:06:54 +0800
Message-ID: <CAN8cciawHATkTwuAZB7pNBdP7dUW5twiMGJM4eeALMA5j0ydVQ@mail.gmail.com>
References: <l28nen$jns$1@ger.gmane.org> <s5h1u44uh1m.wl%tiwai@suse.de>
 <l2hc35$42d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C41D2616FE
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 10:06:55 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id e14so10904089iej.24
 for <alsa-devel@alsa-project.org>; Sat, 05 Oct 2013 01:06:55 -0700 (PDT)
In-Reply-To: <l2hc35$42d$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> First off, take alsa-info.sh output on 3.8.8 kernel where the internal
>> mic works.  Run the script with --no-upload option, and keep the
>> output.
>>
>
> Nice script. I did so and used "diff" to compare the two.
>
> This way, I saw, that not only "Microphone" disappeared but "Capture" was
> added.
>
> So I pushed "Capture" to maximum volume and unmuted the channel and... now
> my microphone works!
>
> IMHO it is a bit confusing if "Microphone" is renamed to "Capture" ;)
>
> And another thing, that seems to be misnamed, is the "Internal microphone
> boost" setting. If an external microphone is plugged in, then this setting
> also applies to this microphone. So maybe it would be better to name it
> "Microphone boost"?
>


if your external mic and internal mic are 0x1b and 0x1f , the mic boost at
audio selector 0x17 is common to both mics as the driver did not use node
0x18 (another mux)



!!DMI Information
 !!---------------

-Manufacturer: LENOVO
-Product Name: 7505
-Product Version: Lenovo IdeaPad N581
-Firmware Version: 5ECN39WW(V3.05)
+Manufacturer:      LENOVO
+Product Name:      IdeaPad U310
+Product Version:   Lenovo U310
+


 !!PCI Soundcards installed in the system
 !!--------------------------------------

-00:1b.0 Audio device: Intel Corporation Panther Point High Definition
Audio Controller (rev 04)
+00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
Family High Definition Audio Controller (rev 04)
+

 !!Advanced information - PCI Vendor/Device/Subsystem ID's
-!!-------------------------------------------------------
+!!--------------------------------------------------------

 00:1b.0 0403: 8086:1e20 (rev 04)
- Subsystem: 17aa:3977
+    Subsystem: 17aa:3977
+


 !!HDA-Intel Codec information
 !!---------------------------
@@ -110,7 +119,7 @@
 Address: 0
 AFG Function Id: 0x1 (unsol 1)
 Vendor Id: 0x14f1506e
-Subsystem Id: 0x17aac033
+Subsystem Id: 0x17aa4009
 Revision Id: 0x100003
 No Modem Function Group found
 Default PCM:

 Node 0x1b [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x00011334: IN OUT EAPD Detect
     Vref caps: HIZ 50 80
   EAPD 0x2: EAPD
-  Pin Default 0x95a70120: [Fixed] Mic at Int Top
-    Conn = Analog, Color = Unknown
-    DefAssociation = 0x2, Sequence = 0x0
+  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
+    Conn = Unknown, Color = Unknown
+    DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00: VREF_HIZ
-  Unsolicited: tag=38, enabled=1
-  Power states: D0 D1 D2 D3 D3cold EPSS
+  Unsolicited: tag=00, enabled=0
+  Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
 Node 0x1f [Pin Complex] wcaps 0x400501: Stereo
+  Control: name="Speaker Phantom Jack", index=0, device=0
   Pincap 0x00000010: OUT
-  Pin Default 0x92170110: [Fixed] Speaker at Int Front
+  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
-  Power states: D0 D1 D2 D3 D3cold EPSS
+  Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
-     0x10* 0x11
+     0x10 0x11*
 Node 0x23 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
+  Control: name="Internal Mic Boost Volume", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=0, ofs=0
+  Control: name="Internal Mic Phantom Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x2f, mute=0
-  Amp-In vals: [0x03 0x03]
+  Amp-In vals:  [0x04 0x04]
   Pincap 0x00000020: IN
-  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
-    Conn = Unknown, Color = Unknown
-    DefAssociation = 0xf, Sequence = 0x0
+  Pin Default 0x90a60150: [Fixed] Mic at Int N/A
+    Conn = Digital, Color = Unknown
+    DefAssociation = 0x5, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
-  Power states: D0 D1 D2 D3 D3cold EPSS
+  Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0


 !!Sysfs Files
 !!-----------
@@ -759,14 +1020,14 @@
 /sys/class/sound/hwC0D0/init_pin_configs:
 0x19 0x04211040
 0x1a 0x04a11030
-0x1b 0x95a70120
+0x1b 0x400001f0
 0x1c 0x400001f0
 0x1d 0x400001f0
 0x1e 0x400001f0
-0x1f 0x92170110
+0x1f 0x90170110
 0x20 0x400001f0
 0x22 0x400001f0
-0x23 0x400001f0
+0x23 0x90a60150
