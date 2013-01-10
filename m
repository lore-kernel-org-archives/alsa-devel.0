From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Thu, 10 Jan 2013 22:41:25 +0800
Message-ID: <CAN8ccibjR2Ttn1NwoOZfcoUijdC=8kU=wghOzs4ob+HGs7ohgQ@mail.gmail.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
 <20130105071605.GA11323@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 8106A261609
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 15:41:27 +0100 (CET)
Received: by mail-ie0-f173.google.com with SMTP id e13so829695iej.18
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 06:41:26 -0800 (PST)
In-Reply-To: <20130105071605.GA11323@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

> Do you require feedback from me about this?  As far as I can tell it's
just
> an observation which might partly explain why the speaker doesn't work on
> the S7020.

Peter mentioned that he still get sound from headphone and no sound from
speaker for auto model, Mic is not working , red light for the optical spdif

If is strange that amp-in values of all connections are the same

Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC260 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x22 0x22] [0x22 0x22] [0x22 0x22] [0x22 0x22] [0x22 0x22]
[0x22 0x22] [0x22 0x22]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 7
     0x12 0x13* 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Control: name="Capture Switch", index=1, device=0
  Control: name="Capture Volume", index=1, device=0
  Device: name="ALC260 Analog", type="Audio", device=2
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
[0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  Converter: stream=3, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 8
     0x12 0x13 0x14 0x15 0x16* 0x07 0x0f 0x10

However using generic model he can get sound from speaker but no sound from
headphone
