From: Randy Li <lxr1234@hotmail.com>
Subject: Re: Strange sound of IDT 82hd206xx6 at font port in
	AC97 mode
Date: Mon, 3 Feb 2014 19:20:19 +0800
Message-ID: <BLU0-SMTP152CB5A9E258F13147FEC4EADAB0@phx.gbl>
References: <BLU0-SMTP22F128862C405DED98AB89ADAB0@phx.gbl>
 <s5h38k0315j.wl%tiwai@suse.de>
 <BLU0-SMTP10854199531FAD7D7E9152EADAB0@phx.gbl>
 <s5hy51s1m8l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s36.blu0.hotmail.com (blu0-omc3-s36.blu0.hotmail.com
 [65.55.116.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 547BD2607C8
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 12:20:27 +0100 (CET)
In-Reply-To: <s5hy51s1m8l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

? 2014?02?03? 19:14, Takashi Iwai ??:
> At Mon, 3 Feb 2014 19:10:58 +0800, Randy Li wrote:
>> 
> ? 2014?02?03? 19:07, Takashi Iwai ??:
>>>> At Mon, 3 Feb 2014 15:01:00 +0800, Randy Li wrote:
>>>>> 
>>>>> 
>>>> Hello My mainboard is ECS A780GM-A, the sound chip in it is
>>>> IDT 82HD206XX6, it shows that below 00:14.2 Audio device:
>>>> Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA)
>>>> Subsystem: Elitegroup Computer Systems Device 2816 Control:
>>>> I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>>> Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF-
>>>> FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort-
>>>> >SERR- <PERR- INTx- Latency: 64, Cache Line Size: 64 bytes
>>>> Interrupt: pin A routed to IRQ 16 Region 0: Memory at
>>>> f9ff0000 (64-bit, non-prefetchable) [size=16K] Capabilities:
>>>> [50] Power Management version 2 Flags: PMEClk- DSI- D1- D2-
>>>> AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+) Status: D0
>>>> NoSoftRst- PME-Enable- DSel=0 DScale=0 PME- Kernel driver in
>>>> use: snd_hda_intel
>>>> 
>>>> In my bios I don't have a switch to make the font port mode
>>>> into AC97 or HD Audio. In windows you need to install a
>>>> driver and set the font port into AC97.
>>>> 
>>>>> HD-audio front panel should be connected in HD-audio mode.
>>>>>  Otherwise something must go wrong.
>>>> 
> But I can't, the hardware of font port is a AC97 port, not a
> HD-audio one. And as I have mentioned before, in BIOS, there is no
> such option to switch the font port mode between HD-audio nor
> AC97. In windows, you have to do that with driver's control panel.
> 
>> Then you can't expect that everything works.  For example, the
>> jack detection is known to be broken if you connect with AC97
>> panel. For disabling the jack detection, put "jack_detect = no"
>> to the hint in the early patching.  See
>> Documentation/sound/alsa/HD-audio.txt for details.
> 
I use pulseaudio, I will have a try.
>> For fixing the rest, the disordered channels, you need to
>> identify which pin corresponds to which I/O, then remap via
>> pincfg in the early patching.  hda_analyzer and hda-jack-retask
>> would be your help.
> 
> 
Sadness, I lack the knowledge of sound driver, I will try to learn
more.
>> Takashi
> 
>>>> In Linux, you can use the font port, but it seems that audio
>>>>  channel is wrong, I can't hear the sound in some part of a
>>>> film and I can hear the stranger accent of sound in the other
>>>> part of a film(or a music). But all the 7.1 channel in the
>>>> back ports can output the sound match my mircophone(all are
>>>> the same). How to fix the problem?
>>>> 
>>>>> You need to switch to HD-audio mode, at first.
>>>> 
>>>> 
>>>>> Takashi
>>>> 
>>>> Kernel is 3.4.77
>>>> 
>>>> 
>>>> ayaka
>>>>> 
>>>> 
>>>> 
>> 
> 
> 
Thank you every much
ayaka
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJS73tzAAoJEPb4VsMIzTzi/pIH/17pnS6fv6W8eJIT5a+q+r1D
KrtOCauRccBut73Bw0ws3f31grRTIkTKPr6vcn8p+i7AxnIjDUibllLUK15HvFNz
XcdNVmpYgbY1+ljToktqnIozGpf2Ml4H6chk7aDbdWjINNB3ugV1IrcCWJop4nOj
3LNpEKjM2nVbKkf/jZoAtpe9Q8EImWJBZcofxsFEZ/bWenf5A7BDS8GfAuNWHrZJ
QWqAGAGkuxz9t8OoiUeGbdM0RjasX4LQRxH3x+2uZxzvaN6QgLFOpHq1wjFRdRLc
+XNFATVjxueNDsb+0KNLLUtVTfw/sW/c6fSnc3fueHOSLwtYzrbNLThH80sCu8o=
=JuPM
-----END PGP SIGNATURE-----
