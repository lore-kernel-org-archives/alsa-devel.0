From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Attempting to understand odd snd-usb-audio code
	and behavior
Date: Mon, 22 Jan 2018 15:40:03 +0000
Message-ID: <2180450.qzCeTlsBey@kamdesktop>
References: <2006820.TBXnYHJvYE@kamdesktop>
 <f5769b3d-0bb1-cd15-90a6-3983cb28f8ff@ladisch.de>
 <4997219.KIItTR1t2S@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 89346266E07
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 16:40:06 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id t74so17241629wme.3
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 07:40:06 -0800 (PST)
Received: from kamdesktop.localnet
 (2.b.7.c.1.4.7.d.9.e.d.f.7.0.9.e.f.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29af:e907:fde9:d741:c7b2])
 by smtp.gmail.com with ESMTPSA id r64sm6571750wma.15.2018.01.22.07.40.04
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jan 2018 07:40:04 -0800 (PST)
In-Reply-To: <4997219.KIItTR1t2S@kamdesktop>
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
List-Id: alsa-devel@alsa-project.org

On Monday 22 Jan 2018 14:06:08 Keith A. Milner wrote:
> On Wednesday 23 Aug 2017 14:52:43 Clemens Ladisch wrote:
> > Keith A. Milner wrote:
> > >>> kernel: [ 1987.452947] usb 1-1: Unable to change format on ep #8e:
> > >>> already in use>
> > > 
> > > So the error messages are due to a userspace app trying to open playback
> > > and capture at the same time?
> > 
> > For this device, playback requires a running capture stream to determine
> > the rate of packets.  This error happens when the application tries to
> > open the capture stream after the playback stream.  (If the format does
> > not actually need to change, the error message is misleading.)
> > 
> > Your actual problem is that the device does not send any capture packets.
> 
> OK, I found some more time to look at this.
> 
> The background is a Roland device. The device descriptor is attached, but it
> seems to be common to a lot of Roland devices.
> 
> Specifically on this device, the Playback endpoint is 0x0d and there is a
> related Implicit feedback endpoint at 0x8e.
> 
> I have USB traces of the device operation under Windows and the (non)
> operation under Linux. The primary difference seems to be that, under
> Windows, the Implict Feedback endpoint (0x8e) is opened prior to playback
> commencing. Given previous discussions (and further research) on Implicit
> feedback, this makes sense.
> 
> Under Linux, this does not happen.
> 
> I've been studying the code in pcm.c and endpoint.c to work out why this is,
> and have some questions on the code function.
> 
> The flow of the code to deal with implict feedback setup in pcm.c is,
> roughly, as follows:
> set_sync_endpoint
>   set_sync_ep_implicit_fb_quirk
>      search_roland_implicit_fb
> 
> set_sync_ep_implicit_fb_quirk seems to deal with quirks relating to implicit
> feedback and, within this, is a specific check for Roland which ends up
> branching to "add_sync_ep" which adds a new endpoint via endpoint.c
> function snd_usb_add_endpoint and assigns this as as the sync endpoint:
> 
> 	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
> 						   alts, ep, !subs->direction,
> 						   SND_USB_ENDPOINT_TYPE_DATA);
> 
> 	subs->data_endpoint->sync_master = subs->sync_endpoint;
> 
> Within endpoint.c, this new endpoint is added to chip->ep_list :
> 
> 	list_add_tail(&ep->list, &chip->ep_list);
> 
> After set_sync_ep_implicit_fb_quirk has completed it returns to
> set_sync_endpoint which then checks that there are at least 2 endpoints:
> 
> 	if (altsd->bNumEndpoints < 2)
> 		return 0;
> 
> However, in the case I'm testing, on this device, this test fails as
> bNumEndpoints is 1, even though we've just added a second endpoint for the
> Implicit feedback.
> 
> Looking at the code, endpoint.c does not alter bNumEndpoints, which seems to
> be a fundamental piece of data held against the usb_host_interface instance
> and, presumably, set from the device descriptor by underlying kernel code.
> 
> My question is, is the test for bNumEndpoints correct here? From what I can
> gather, the whole point of the set_sync_ep_implicit_fb_quirk and
> search_roland_implicit_fb code is to add an endpoint that can then be used
> by set_sync_endpoint, but this seems to be ignored by doing the test for
> bNumEndpoints.
> 
> Or, perhaps, is it that the way that this endpoint is added is incorrect.
> 
> I have, by the way, tried commenting out the bNumEndpoints test, and it
> fails at the subsequent sync-pipe check with:
> 
> invalid sync pipe. bmAttributes 00, bLength 0, bSynchAddress 00
> 
> To me this suggests the endpoint isn't being set correctly somehow.
> 
> Any pointers gratefully received.

Answering my own question, I've just realized that the objective of 
set_sync_endpoint is to set the sync endpoint as follows:

subs->data_endpoint->sync_master = subs->sync_endpoint;

The quirks in set_sync_ep_implicit_fb_quirk do this directly, so the remainder 
of the code in set_sync_endpoint is irrelevant for these devices.

My next course of action is to try to work out why the sync endpoint doesn't 
seem to be opened.

Cheers,

Keith
