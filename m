From: Matthew Gregan <kinetik@flim.org>
Subject: Re: [pulseaudio-discuss] Immediate underrun with
 PulseAudio ALSA plugin when PA and ALSA buffer sizes differ
Date: Mon, 30 Jul 2012 17:49:57 +1200
Message-ID: <20120730054957.GA2610@flim.org>
References: <20120718221439.GA2875@flim.org> <5007CBA9.5050808@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C7F26525A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 07:49:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5007CBA9.5050808@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

At 2012-07-19T10:56:09+0200, David Henningsson wrote:
> What I meant was that I can successfully run your latency test with
> 10 ms here - when I go down to 5 I start to get xruns. In that
> context, getting problems around 50 - 100 ms of latency is quite a
> lot.

Oh, right.  Of the three bug reports I have, two reports are from users with
HDA, the third was using snd_ca01016 and tsched=0 with a fixed 200ms
latency.  On my system (Lenovo W510, 1.73GHz Core i7, HDA/CX20585), PA will
creep up to 46-56ms over multiple days of use (across multiple laptop
suspend/resume cycles), but will run with 16ms fine after restarting PA.

> Meanwhile, you could make a workaround like this in ~/.asoundrc:
> 
> pcm.pulse_no_underrun {
>   type pulse
>   handle_underrun 0
> }
> 
> and then open the device "pulse_no_underrun". With that workaround I
> can run with 1 ms without problem in your latency test. (We can't
> ignore underruns for everyone though, as that would break
> applications depending on these being delivered as well. Been there,
> done that.)

Thanks, this seems to work around the problem the way I'd hoped.  It's not
ideal, because you end up spinning on an instantly ready fd until the PCM's
buffer has filled, but it's better than anything I had managed to cook up in
the meantime.  I've added code to set this at runtime[0] via the local
config interface, inspired by WINE's winealsa.drv, which explicitly enables
rather than disables handle_underrun.

[0] https://github.com/kinetiknz/cubeb/commit/1aa0058d0729eb85505df104cd1ac072432c6d24

Thanks,
-mjg
