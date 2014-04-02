From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/44 v3] Enhancement of support for
	Firewire devices
Date: Wed, 02 Apr 2014 20:15:57 +0900
Message-ID: <533BF16D.6090803@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 524C12654C9
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 13:16:03 +0200 (CEST)
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens,

I thinks you're under reviewing this series.

I have a plan to re-post this series with some fixes about a reported 
bug and logs. But if you have comments for large modification, I'll 
cancel it and start to work for it, to reduce my work to post patches. 
Currently do you have any comments?



Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


(Mar 21 2014), Takashi Sakamoto wrote:
> This series is an update for my previous series:
> [alsa-devel] [GIT PULL][PATCH 00/39 v2] Enhancement of support for Firewire
> devices
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073868.html
>
> Updates since previous pull-request:
> firewire-lib:
>   - remove packet sorting
>   - remove adding transfer delay to out-packets
>   - fix a bug of MIDI capturing for several ports
>   - add detecting discontinuity of packets
>   - add a support for deferred transaction
>   - add some flags for device's quirk related to AMDTP packets
>   - improve return value of some AV/C general commands
> fireworks:
>   - add a workaround for out-of-specification dbc meaning
>   - add a workaround for AudioFire9 firmware
>   - add a workaround for firmware version 5.5
> bebob:
>   - add some flags for device's quirk related to AMDTP packets
>   - add a workaround for discontinuity of packets at bus reset
>   - add workarounds for M-Audio spefial Firewire series
>
> This time I intentionally add no restriction of version for Fireworks because
> I confirmed that my model doesn't always transmit packets with disorder. I
> expect users to retry starging streams several times till detecting no
> discontinuity of packets.
> [alsa-devel] [PATCH 09/39] firewire-lib: Add sort function for transmitted packet
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074157.html
>
> I note that a workaround for M-Audio special Firewire series at [44/44] relates
> to Linux Firewire subsystem. Please follow:
> Generating bus-reset by kernel module in the other subsystem
> http://sourceforge.net/p/linux1394/mailman/linux1394-devel/thread/5326B651.4070309%40sakamocchi.jp/
>
> ----------------------------------------------------------------
>
> The following changes since commit 2df6742f613840a0b0a1590fb28f7af5b058a673:
>
>    ALSA: hda - verify pin:cvt connection on preparing a stream for Intel HDMI codec (2014-03-20 07:36:17 +0100)
>
> are available in the git repository at:
>
>    https://github.com/takaswie/sound.git request
>
> for you to fetch changes up to aa0564fdd013e5754b73ba89b50c722bbedbc4ac:
>
>    firewire/bebob: Add a workaround for M-Audio special Firewire series (2014-03-21 19:35:04 +0900)
>
> ----------------------------------------------------------------
