From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sun, 30 Mar 2014 14:21:38 +1100
Message-ID: <53378DC2.3090603@gmail.com>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <1403282253300.13982@beth> <5336BC20.1050806@gmail.com>
 <1403292231190.1294@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 283F3261B31
 for <alsa-devel@alsa-project.org>; Sun, 30 Mar 2014 05:22:20 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id x10so6510800pdj.37
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 20:22:19 -0700 (PDT)
In-Reply-To: <1403292231190.1294@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@xwax.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On 30/03/14 09:57, Mark Hills wrote:
> Thanks. I took a look and I think I have a similar concern to Daniel for 
> readability. The code should really be shared with the quirk on a single 
> endpoint.
I guess a significant rewrite will be required.

> The duplicate code in the patch already has different handling of 
> maxpacksize and datainterval -- is that intentional? It's apparent because 
> the new code ignores the values given in the quirk.
Not intentional, maxpacksize and datainterval happened to be identical
for both endpoints on the Mbox.

> If the data in the quirk is truly redundant, then really it should not be 
> present, or have the structure to use it -- it is misleading like this.
Yeah, I agree.  I have an idea.  The following is an excerpt from lsusb
for the Mbox:

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0130  1x 304 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0130  1x 304 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0

Looking at the current struct for a snd_usb_audio_quirk:

struct snd_usb_audio_quirk {
        const char *vendor_name;
        const char *product_name;
        int16_t ifnum;
        uint16_t type;
        const void *data;
}

It is quite versatile, we shouldn't need to alter the quirk struct, just
the data it holds.  Is an array of audioformats for this kind of
interface the ideal choice?

Also, maybe we can read bNumEndpoints to determine if it is a
multi-endpoint interface and act accordingly, then we don't need an
extra element in snd_usb_audio_quirk.

How is a shared interface supposed to be initialised when it has
different properties for each endpoint?

> Yes, I dug out a Novation Twitch here. It uses different number of 
> channels (and hence buffer sizes) on the record and playback endpoints. At 
> very least other Focusrite devices will have this, too.
Interesting.

> It seems the assumption that an enpoint has sole ownership of the 
> interface is quite deeply spread in the code. For example, set_format() 
> called as part of snd_usb_pcm_prepare().
I am still trying to wrap my head around this one, but it sounds like
the major stumbling block with the current code?

> But I'm suprised your Mbox deals with the prepare step, perhaps it is 
> suprisingly tolerant. Did you confirm that you could start and stop a 
> recording during playback and that both streams were truly working?
Yes, I can start and stop recording while headphones are blasting, and
my microphone works.

> Specifically as snd_usb_pcm_close() shuts down the whole interface. Is 
> your Mbox continuing smoothly when this happens on one of the streams?
I use JACK so I'm not sure if the streams are ever closed until I
shutdown the server.

Damien
