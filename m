From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: Re: How to define card specific pcm devices?
Date: Fri, 17 Aug 2012 17:50:40 +0300
Message-ID: <1345215040.2530.26.camel@IT-D-4QB9Z4J>
References: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id B1DEB26614F
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 16:20:55 +0200 (CEST)
Received: from smtp1.digia.com (unknown [127.0.0.1])
 by IMSVA80 (Postfix) with ESMTP id 4D97937003A
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 17:50:41 +0300 (EEST)
Received: from IT-EXCAS02-HKI.it.local (unknown [10.9.52.71])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp1.digia.com (Postfix) with ESMTP id 3E3F8370036
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 17:50:41 +0300 (EEST)
In-Reply-To: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
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

Ping?

If card specific pcm definitions are not possible, would it be
acceptable to have a generic "front_left:CARD" or "first_channel:CARD"
pcm, which would transform "front:CARD" or "hw:CARD" into a mono device?

-- Tanu


On Fri, 2012-08-10 at 14:25 +0300, Tanu Kaskinen wrote:
> Hi,
> 
> I'm writing UCM configuration for RX-51 (Nokia N900), and I have a
> problem: "hw:RX51" can't be opened in mono mode, but there's only one
> integrated mono microphone, and its audio is routed to the left input
> channel. Applications will get only silence in the right channel when
> they use "hw:RX51".
> 
> The best solution that I have come up is to define a pcm that converts
> "hw:RX51" into a mono device. The problem is that I don't know how
> exactly to do that. I guess the route plugin can be used for that:
> 
> pcm.rx51_mono_from_left {
>         type route
>         slave.pcm hw:RX51
>         slave.channels 2
>         ttable.0.0 1
> }
> 
> I tried putting that definition in /usr/share/alsa/cards/RX-51.conf (and
> also RX51.conf, since it's not entirely clear to me when the dash should
> be omitted). I have this in the UCM configuration:
> 
> Value {
>         CapturePCM "rx51_mono_from_left"
>         CaptureChannels "1"
> }
> 
> This is printed to the PulseAudio log:
> 
> (alsa-lib)pcm.c: Unknown PCM rx51_mono_from_left
> 
> So the rx51_mono_from_left definition is not loaded. I'm not terribly
> surprised: I guess the card configuration files are loaded only when
> necessary, and when PulseAudio tries to open "rx51_mono_from_left",
> alsa-lib can't really know that it's somehow related to the RX-51 card.
> 
> How should I solve this?
> 
