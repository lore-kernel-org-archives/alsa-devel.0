From: Andriy Gapon <avg@icyb.net.ua>
Subject: oss plugin: SNDCTL_DSP_SETFRAGMENT problems
Date: Thu, 01 Mar 2012 11:59:59 +0200
Message-ID: <4F4F489F.3010800@icyb.net.ua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5905519569656093697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from citadel.icyb.net.ua (citadel.icyb.net.ua [212.40.38.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 81549103998
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 10:59:54 +0100 (CET)
Received: from porto.starpoint.kiev.ua (porto-e.starpoint.kiev.ua
	[212.40.38.100])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id LAA03842
	for <alsa-devel@alsa-project.org>; Thu, 01 Mar 2012 11:59:52 +0200 (EET)
	(envelope-from avg@icyb.net.ua)
Received: from localhost ([127.0.0.1])
	by porto.starpoint.kiev.ua with esmtp (Exim 4.34 (FreeBSD))
	id 1S32ng-000CMr-C3
	for alsa-devel@alsa-project.org; Thu, 01 Mar 2012 11:59:52 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5905519569656093697==
Content-Type: text/plain; charset=X-VIET-VPS
Content-Transfer-Encoding: 7bit


First, a disclaimer: what I'd like to discuss seems to affect a FreeBSD OSS
implementation.

After looking at the code in oss_pointer() and in snd_pcm_ioplug_hw_ptr_update()
it seems that the code depends on OSS driver using exactly the same buffer size
as specified by the buffer_size parameter.
Otherwise the code that handles hw pointer cycling would calculate a delta
incorrectly.

Then, it seems that oss_hw_params() tries to enforce the driver's buffer size
using SNDCTL_DSP_SETFRAGMENT.  But in the OSS specification there are oh so many
warnings about it:
http://manuals.opensound.com/developer/SNDCTL_DSP_SETFRAGMENT.html
> It's important to understand that this call just sets the size hint. There is
> no guarantee that the requested size gets used.
...
> It's very important to make this ioctl call as early as possible after
> opening the device since otherwise the call may not have any effect. In
> particular this call must be made before calling read, write or some other
> ioctl calls.
...
> This ioctl call will return an error only if the argument value is incorrect
> or if the call is made in a wrong place. Even if the call returned OK there
> is no guarantee that the requested buffer size will be used. This ioctl call
> sets just the size hint and the driver may or may not honor the request.

I see at least two issues with the oss plugin code:

o Actual OSS driver buffer size value is never queried/verified if the
SNDCTL_DSP_SETFRAGMENT call is successful

o  Apparently oss_hw_constraint() function is called before oss_hw_params() and
the former makes SNDCTL_DSP_CHANNELS ioctl calls which change a configuration of
the OSS driver and may affect the future SNDCTL_DSP_SETFRAGMENT call.  This also
violates the order described here:
http://manuals.opensound.com/developer/callorder.html

There is a retry loop in oss_hw_params() which closes and re-opens an OSS
device, but that loop is only activated on SNDCTL_DSP_SETFRAGMENT hard failure;
there is no handling for the case where the ioctl succeeds but the resulting
buffer size differs from the requested one.

I think that to nullify any effects of oss_hw_constraint() on the OSS driver
configuration there should be a call to SNDCTL_DSP_RESET at the end of the
function.  Alternatively, there could be a call to this ioctl before
SNDCTL_DSP_SETFRAGMENT.  Or perhaps there could be resets at both places...

Ideally, of course, the OSS plugin should query the exact OSS driver buffer size
and alter the buffer_size parameter accordingly.  But this is a bit more work.

What do you think?
Thank you.
-- 
Andriy Gapon

--===============5905519569656093697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5905519569656093697==--
