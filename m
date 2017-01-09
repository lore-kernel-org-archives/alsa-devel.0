From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: additional high input device for snd-dice (A&H Zed
	R16)
Date: Mon, 09 Jan 2017 23:55:04 +0000
Message-ID: <CA+aoAJcxnJEM2J9pH64fd4tJF32rG5MM2EQz6m+Nirp5jkU7kw@mail.gmail.com>
References: <CA+aoAJfjN83TdDdQnA05KmQs29UiLSQNkdV7OvLsf7S7vQgi+w@mail.gmail.com>
 <527f6748-c34f-a7a1-4f17-376dc1dace4f@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C565E26701D
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 00:55:15 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id c85so113137910wmi.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2017 15:55:15 -0800 (PST)
In-Reply-To: <527f6748-c34f-a7a1-4f17-376dc1dace4f@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you for your response.

My statement was a little tongue in cheek after thought to the actual
comment.
All, I'm really hoping is that the full channel count will be available for
ALSA users.




On Tue, 10 Jan 2017 at 03:33 Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> On Jan 9 2017 15:59, Allan Klinbail wrote:
> > Hi,
> >
> > I noticed on the changelog that some devices are able to access all
> > channels without doing any .asoundrc funkiness. Form 4.6 kernel onwards
> >
> >
> >    - Add support for previously unavailable higher PCM channels on
> certain
> >    devices with high channel count, notably Focusrite Saffire PRO 40,
> >    Focusrite Liquid Saffire 56, and TC Electronic Studio Konnekt 48.
> These
> >    devices spread the PCM and MIDI channels across 2 tx + 2 rx IEEE 1394
> >    channels instead of just 1 tx + 1 rx IEEE 1394 channel, as most other
> >    devices do.
> >
> >
> > Pretty sure I've tested with 4.6 and wasn't able to achieve this with my
> > device.  But can test again with 4.8 if I am wrong.
> >
> > My device is an Allen and Heath Zed R16..
> > While latency performance in the way ALSA works is not satisfactory  for
> my
> > usage others may wish to use this device with ALSA for simplicity.
> (remove
> > the need for FFADO entirely as there is no software mixer for this device
> > and remove the need for any MIDI bridge)
> >
> > Currently under ALSA in 44.1k or 48k the device has 16 inputs and 16
> > outputs on the first firewire channel, and then and additional 10 ins and
> > 10 outs on the second.
> >
> > If this is any help, here is the vendor info, as used by FFADO
> >
> >
> > { # Allen and Heath Zed R16.  Information from Brendan Pike.
> >     vendorid    = 0x000004C4;
> >     modelid     = 0x00000000;
> >     vendorname  = "Allen and Heath";
> >     modelname   = "Zed R16";
> >     driver      = "DICE";
> >     mixer       = "Generic_Dice_EAP";
> > }
> >
> >
> > On that latency topic- just voicing my opinion and I don't expect change.
> >
> > When the paradigm of using periods/frames and buffers is common across
> all
> > OS and driver platforms, I don't believe that the driver should force
> > developers to implement a new method, even if there are better ways of
> > doing things.
>
> It's 2017 and the paradigm was already shifted since early 2000.
> Timer-based scheduling is more popular in recent commercial operating
> systems, to achieve PCM frame queueing delay within the size of period
> in PCM buffer, with better power consumption.
>
> On the other hand, stuffs in your Linux audio still adhere old paradigm,
> against their essential requirement.
>
> By the way, ALSA firewire stack supports both programming models. It
> doesn't forces people for one of the directions.
>
> That might be okay for small open source projects, but bigger
> > commercial applications would not be likely to maintain separate
> > configuration options for Linux, they are more likely to drop Linux
> > altogether if forced to adopt
> >  I also know that Takashi S, does not agree but as FFADO devs have agreed
> > to keep the driver in FFADO I don't mind..
>
> My agreement is not so important for this topics, and it's just due to
> few developers for this kind of devices. Recently I use more time for
> ALSA itself, and have enough distance from this kind of devices, audio
> and music units on IEEE 1394 bus,
>
> Anyway, thanks for your report.
>
>
> Regards
>
> Takashi Sakamoto
>
