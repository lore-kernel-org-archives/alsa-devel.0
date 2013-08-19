From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
	depop
Date: Mon, 19 Aug 2013 11:29:32 -0600
Message-ID: <521255FC.4000003@wwwdotorg.org>
References: <1376914682-3606-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 05F612617A6
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 19:29:37 +0200 (CEST)
In-Reply-To: <1376914682-3606-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/19/2013 06:18 AM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> Add mute/unmute control in widget event and modify the power on/off sequence to avoid pop noise.

This version breaks both headphone and speaker output. I see the
following issues:

1)

After a reboot, if all of "{HP,Speaker} [LR] Playback Switch" are
on/unmuted, and I start playback, then something sets all those controls
to off/muted. I suspect this is related to function rt5640_hp_event()
twiddling the same RT5640_[LR]_MUTE bits that the hp_[lr]_enable_control
controls twiddle.

2)

If playback is running, and (1) has caused all output to be muted, and I
then run alsamixer and enable/unmute "HP L Playback Switch", I hear
sound on both the L and R headphone channels for a very brief time, then
output switches to the L channel only. Similar happens if I unmute "HP R
Playback Switch" first. Unmuting both switches does produce stereo sound
as expected.

I don't know if this also happens for the speaker output, since the
board is too far away from me to easily tell which speakers are playing.
