From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 14:33:03 +0200
Message-ID: <534BD57F.6000006@ladisch.de>
References: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0A99326164C
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 14:33:04 +0200 (CEST)
In-Reply-To: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Storer <rstorer@ntlworld.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Richard Storer wrote:
> My first issue is for some reason booting Linux with my device already
> attached to the USB port produces no audio output, however capture is
> functioning.
> I've tried mute, unmute via alsamixer but it seems like the amplifier
> circuit inside hasn't turned itself on properly.
> The cure for this (and 100% reproducible) would be to unplug / replug
> the USB cable or simply connect to USB after Linux has fully loaded.

Are there any mixer controls that have a different value in these
situations?  (See the output of "amixer scontents" for your device.)

> While Line-In capture does function on this device the signal levels
> are extremely low.
> Unfortunately there is no Line-In mixer control for my device

What is the output of "amixer scontents" for your device?


Regards,
Clemens
