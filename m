From: Matthew Gregan <kinetik@flim.org>
Subject: Re: Immediate underrun with PulseAudio ALSA plugin
 when PA and ALSA buffer sizes differ
Date: Thu, 19 Jul 2012 10:14:39 +1200
Message-ID: <20120718221439.GA2875@flim.org>
References: <CAN8ccibduuRoPH1yFVWCbaoV2vqVMJHutmfj=E8DT9xBbAXuyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
 by alsa0.perex.cz (Postfix) with ESMTP id C41FF264F15
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 00:14:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN8ccibduuRoPH1yFVWCbaoV2vqVMJHutmfj=E8DT9xBbAXuyA@mail.gmail.com>
 <5005049C.5000806@canonical.com>
 <1342502963.14027.24.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>, David Henningsson <david.henningsson@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

At 2012-07-17T10:59:23+0530, Arun Raghavan wrote:
> The necessary values are available via pa_stream_get_buffer_attr().
> Potentially we could use this in the pulse_pointer() function to update
> the corresponding snd_pcm_t's period/buffer sizes, but I don't know if
> this is kosher with regards to what alsa-lib expects plugins to be
> doing.

Right, I assume alsa-lib expects the buffer size to be static after
configuration is complete, and from a quick search through the source of
alsa-lib and alsa-plugins I couldn't find any code that updated the buffer
size after configuration.

> If this is not sufficient for the initial update, from what I can see,
> snd_pcm_set_params() first sets period/buffer sizes, queries them for
> later calculations, and then commits them with snd_pcm_hw_params(). If
> we could move the querying to after the params are committed (and in
> this case, the stream is connected and buffer attributes are
> negotiated), that would solve your problem. Again, I'm not sure what
> side-effects this might have, but I've attached a draft untested patch
> for it.

Unless I'm missing something, the queried buffer_size in that function is
only used to set the start_threshold later on, and doesn't update
pcm->buffer_size.

At 2012-07-17T08:22:20+0200, David Henningsson wrote:
> 100 ms of latency is a lot, even for PulseAudio - is this some
> special hardware?

No, it's just a random value for media playback.  In an older version of the
audio backend we're using in Firefox (which was push rather than pull
based), we used 500ms and hadn't run into this problem in a way that was
obvious to users (i.e. causing broken playback).  I chose a lower latency
for media playback in the new backend in an attempt to flush out bugs before
we introduce features that demand low latency (such as WebRTC).

> Could you clarify what versions of PulseAudio and alsa-plugins
> you're using? The latest improvement to this handling was done less
> than a year ago and might require the latest versions of these
> components.

I'm using Fedora 17, which has alsa-plugins-pulseaudio-1.0.25-3.fc17 and
pulseaudio-1.1-9.fc17.  This was originally discovered by users running
ALSA 1.0.25 on various distros (Ubuntu 12.04 LTS and Arch).  Two of them
happened to have a PA server where the latency had crept up over time, and a
third was running the server with tsched=0 on an Audigy SE (CA0106) with a
minimum latency of 200ms.

I've also tested against the git HEAD of alsa-plugins.

> I think the better solution would be nr 2 in this case. Nr 1 won't
> solve the case where the sink's latency is increased dynamically -
> because the stream is moved, for example.

> I don't know either - and it also does not seem to solve the case
> where the sink's latency is suddenly increased (e g, when the sink
> input is moved to another sink).

At 2012-07-17T15:36:52+0800, Raymond Yau wrote:
> this function does not work for all sound card drivers.
> 
> many pci sound cards have hardware constraints which you cannot select 10ms
> or 100ms period time / buffer time.

That's fine, as long as it fails by either silently using the appropriate
buffer/period sizes and reporting them via the ALSA API, or causes
snd_pcm_set_params to return an error so another configuration can be
attempted.  The problem in this situation is that neither of those things
happen under the conditions I described.

> do you mean the pulse plugin advertise a low latency but the server in fact
> force the application to use a large buffer with high latency?

Yes.  The code in pcm_pulse.c:pulse_hw_constraint reports fixed min/max
sizes for buffers and periods without verifying that the PA server can
honour those values.  When it can't, PA will increase PA stream buffer size
(tlength) as appropriate, but this isn't reflected in the plugin or
ioplug/pcm layers of ALSA, so the calling application can't detect this and
adjust accordingly.

Cheers,
-mjg
