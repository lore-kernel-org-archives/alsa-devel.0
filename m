From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Sat, 27 Nov 2010 15:23:23 +0800
Message-ID: <AANLkTi=So3UMDSbC0j8bvB=P696c=9qKEuH=oaioHG1F@mail.gmail.com>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
	<alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 598A7103804
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 08:23:25 +0100 (CET)
Received: by eyg24 with SMTP id 24so1266993eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 23:23:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/11/22 Jaroslav Kysela <perex@perex.cz>

> On Mon, 22 Nov 2010, pl bossart wrote:
>
> >>> Since the PulseAudio commit 29acfd0e0413a9bd126782763ee2dcf10357546 I
> >>> am seeing errors messages telling me that the information reported by
> >>> snd_pcm_avail_delay is not accurate on the capture path, more
> >>> specifically the delay is lower than the available samples.
> >>
> >> Could you test patch bellow?
> >>
> >>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=ba9332e9192814a5431a3a2505d25d74a9232124
> >
> > Nah, no luck. PulseAudio still reports an error and if I add
> > assert(*delayp >= *availp) the code bombs out.
> > Here is one way to solve the problem. I don't claim it's the right
> > one, but it's compatible with the way the availp value is computed,
> > and it makes the error message go away in PulseAudio.
>
> The double avail_update() calling seems too expensive to me. Could you
> test to use snd_pcm_mmap_capture_avail() instead snd_pcm_avail_update()
> calls (to assign both slave_avail and plugin_avail local variables)?
>
> Also, remove the assert. I think that it may be raised when the stream is
> in some xrun state (with xrun checks disabled). The avail_update can
> return the negative values in this specific configuration.
>
>
The point is the documentation does not mention that the state still remain
as SND_PCM_STATE_RUNNING even when the distance between the application ptr
and the hw_ptr is more than a buffer size , it only mention the device will
do the endless loop.

The only way to know overrun/underrun is to check the avail is larger than
the buffer size when the application set the stop threshold to boundary
instead of buffer size.

so it is incorrect for PA to say this is a driver bug since it disable the
automatic stop when underrun/overrun occur


e.g. dmix also set stop threshold to boundary but aplay can still get xrun
when using small buffer size with plug:dmix

if you set the boudnary to buffer size instead of boundary in
alsa-time-test.c , alsa-lib will tell you that the program is
underrun/overrun


http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___s_w___params.html

PCM is automatically stopped in SND_PCM_STATE_XRUN state when available
frames is >= threshold. If the stop threshold is equal to boundary (also
software parameter - sw_param) then automatic stop will be disabled (thus
device will do the endless loop in the ring buffer).
