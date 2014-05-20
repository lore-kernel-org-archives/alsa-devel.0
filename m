From: VDR User <user.vdr@gmail.com>
Subject: Re: Force an update of the ELD info?
Date: Tue, 20 May 2014 08:01:46 -0700
Message-ID: <CAA7C2qjELb4qUMZWa-hd=aPpLaRt_khx1o-js9FLTuXS9-+srQ@mail.gmail.com>
References: <CAA7C2qjSj7_9vEufx+Jo2Lz3zem3u2-BLqsGRnp966GmkyksGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F98226523B
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 17:01:47 +0200 (CEST)
Received: by mail-ig0-f176.google.com with SMTP id hl10so4948125igb.9
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 08:01:47 -0700 (PDT)
In-Reply-To: <CAA7C2qjSj7_9vEufx+Jo2Lz3zem3u2-BLqsGRnp966GmkyksGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Nobody?

On Tue, May 13, 2014 at 7:56 PM, VDR User <user.vdr@gmail.com> wrote:
> Hi. I was wondering if it's possible to force alsa/drivers to update
> the ELD info yet? If not, is this something that can be added? Reason
> being, htpc users may or may not have their receiver/surround sound on
> at any given time. The ELD info can be used to determine this, and
> thus audio playback can be appropriately set for surround/no-surround
> at any given time. As it is now, to even use surround, the receiver
> must be turned on before the system is booted. That may not always be
> convenient. Also, leaving a receiver on 24/7 is a waste of power,
> generates heat, and puts unnecessary wear & tear on equipment that's
> not being used at the time.
>
> I have been told one way to force an ELD update is to completely
> unload alsa/drivers, and reload them. However, that's very
> inconvenient as it requires plugging in a keyboard, or ssh'ing into
> the box, unloading everything, toggling the receivers power state,
> then reloading everything. That's a pretty disruptive process which,
> if can be avoided, should be.
>
> Also, could someone with the proper knowledge clarify is this is
> something that alsa needs to support, the sound drivers need to
> support, and/or the video drivers need to support? I've heard very
> different answers and would like some clear info on this if anyone has
> any to offer.
>
> In case anyone is wondering, I have multiple linux htpcs connected via
> hdmi to receivers, that are then connected to tvs. These boxes have
> nothing more than an IR receiver connected to them for navigating an
> OSD. All of the boxes are using Nvidia video cards with vdpau
> decoding, and audio-over-hdmi with the snd_hda_intel.
>
> Many thanks for any input!
> -DK
