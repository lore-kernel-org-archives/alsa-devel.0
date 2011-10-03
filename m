From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Mon, 3 Oct 2011 09:35:59 +0800
Message-ID: <CAN8cciZx9sVNcubQ9-s64PjOeu+mt8u-roq9YLYSV_TUo3wHjA@mail.gmail.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
	<B2FD678A64EAAD45B089B123FDFC3ED70166618A6E@inbmail01.lsi.com>
	<s5h8vp7by4m.wl%tiwai@suse.de> <s5h62kbbx1g.wl%tiwai@suse.de>
	<CAJTbaX3OiLNcL2hwJOROK4jLeLhAJKJE-zO5t=VYcP4sP03oUA@mail.gmail.com>
	<s5hy5x7ag8l.wl%tiwai@suse.de>
	<CAN8cciaUNP=mk=7=u+HpMVdwRJ-fRUR1OGS5p9zmfDsMfofqHw@mail.gmail.com>
	<s5hvcs9rzyw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0F310381C
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 03:36:02 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so4666636bkb.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 18:36:01 -0700 (PDT)
In-Reply-To: <s5hvcs9rzyw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/10/1 Takashi Iwai <tiwai@suse.de>:
>> >
>> >> 2. Why Analog devices codec (patch_analog.c) clear
>> >> AC_VERB_SET_CHANNEL_STREAMID on close? (if (do_now)
>> >> =A0 =A0really_cleanup_stream(codec, p);
>> >
>> > It's because AD codecs (according to bug reports) don't like the
>> > sticky-tag feature by some reason. =A0It'll be removed, once when the
>> > real culprit is found.
>> >
>> >
>>
>> http://thread.gmane.org/gmane.linux.alsa.devel/78379
>>
>> Can the converters can retrain the stream tag after suspend/resume ?
>
> No. =A0The flag is cleared in the suspend.
>

The main difference is only AD codecs have Power widget but driver
does not has init verbs for this [Power widget]

e.g. ad1988 has 9 widets support power states ,

Table 13 Widet Parameters (Power states 0f)
Five [Audio Output] , three [Audio Input] and [Power widget] have 00000009


Table 10
widget
No. Name                    Description
19 Mixer Power Down   Power widget Powers down the analog mixer and
associated amps
23 VREF Power Down Vendor defined Powers down the internal and
external VREF circularity
2f BIAS Power Down Vendor defined Powers down the internal
MIC_BIAS_FILT and all MIC_BIAS pins


Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x20 0x21

There are two vendor defined widgets (VREF power down and BIAS power pown)

Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 18
     0x11* 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x24 0x25 0x38 0x39 0x3a
0x3b 0x3c

Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 6
     0x11* 0x12 0x14 0x15 0x16 0x17
