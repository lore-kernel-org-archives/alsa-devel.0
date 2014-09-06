From: Daniel Mack <daniel@zonque.org>
Subject: Re: USB Implicit Feedback
Date: Sat, 06 Sep 2014 13:56:02 +0200
Message-ID: <540AF652.8080501@zonque.org>
References: <op.xlq6q9vfeorkce@apollo13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E17E1264EFF
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 13:56:03 +0200 (CEST)
In-Reply-To: <op.xlq6q9vfeorkce@apollo13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre C <lists@peufeu.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/06/2014 08:53 AM, Pierre C wrote:
> I'm implementing a USB Audio Class 2 device using a Cortex-M4 with high  
> speed USB. So far it works well, the device is recognized by ALSA,  
> playback, capture, sample rate change, and all controls like volume and  
> mute work. I'm using explicit feedback.
> 
> I'd like to use implicit feedback instead,

Why?

> and had some problems...
> 
> With implicit feedback, when playback starts, ALSA should start capture  
> automatically (even if there are no applications requesting capture at the  
> moment) to use the number of capture samples as feedback. But it doesn't.
> 
> So, I'd like to know :
> 
> - Is it actually supported ?

Yes.

> - If it is, what descriptors should I use to make it work ?

The usage mask of bmAttributes of the endpoint should be
USB_ENDPOINT_USAGE_IMPLICIT_FB, along with some other constraints. See
set_sync_endpoint() in sound/usb/pcm.c

Note, however, that we only implemented implicit feedback mode in the
driver because there are devices out there which use such modes. If
you're doing the device-side yourself, I'd actually recommend going for
explicit feedback, especially if that already works for you. Any
particular reason why you want to change that?


Daniel
