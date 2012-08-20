From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Can module snd-aloop (virtual looback device) be
 made clock slave of a real audio device ?
Date: Mon, 20 Aug 2012 12:26:57 +0200
Message-ID: <503210F1.9000800@perex.cz>
References: <1345456315.34107.YahooMailNeo@web39304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 314FC265DB0
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 11:54:39 +0200 (CEST)
In-Reply-To: <1345456315.34107.YahooMailNeo@web39304.mail.mud.yahoo.com>
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
Cc: warjamy@yahoo.com
List-Id: alsa-devel@alsa-project.org

Date 20.8.2012 11:51, James Warden wrote:
> Hello alsa-devel's,
> 
> A while back, I had written a rather hackish method to hook up the
> ALSA virtual loopback device to jack (jackaudio.org) via Jack clients
> alsa_in / alsa_out so that non jack-aware applications that can
> however use ALSA devices "directly" (via alsa-lib) can have their
> audio stream redirected to jack (see my rather lengthy prose at
> http://alsa.opensrc.org/Jack_and_Loopback_device_as_Alsa-to-Jack_bridge).
>
>  There are a few advantages in this method (depends on your use-cases
> of course). But it could be improved (or so I think) by removing the
> following drawbacks:
> 
> The alsa_in/out jack clients are resampling the audio stream to
> synchronize with the device that jack is using. The resampling, done
> by libsamplerate, takes some CPU power. Since many users are using my
> recipe on laptops, this is not always welcome.
> 
> Because snd-aloop is a virtual device, couldn't it be made a clock
> slave of the h/w device that jack is operating on ? This would in
> principle remove the need for resampling. I could imagine that the
> module could be passed an option at loading time (e.g. modprobe
> snd-aloop clock-master=<real h/w device index> or something like
> that)

Use 'PCM Rate Shift 100000' mixer control to fine tune the rate (timing)
for the snd-aloop PCM devices. An example using this solution is the
alsaloop application from the alsa-utils package.

Also note that other controls can expose the audio format on the
playback side, so you can avoid resampling in the alsa-lib completely
for ALSA audio apps. The alsaloop application can give you more hints.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
