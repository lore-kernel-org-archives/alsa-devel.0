From: Shane W <shane-alsa@csy.ca>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
 DG45FC motherboard
Date: Tue, 20 Oct 2009 15:43:53 -0700
Message-ID: <20091020224353.GA23186@csy.ca>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viper.wapvi.bc.ca (viper.wapvi.bc.ca [209.52.235.240])
	by alsa0.perex.cz (Postfix) with ESMTP id E6E2F2455B
	for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2009 18:51:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091020012600.GA6548@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, david@hardeman.nu
List-Id: alsa-devel@alsa-project.org

Hey all,

On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:
> It's <= 0.5 second silence from my experience.

Correct.

> HDMI codec/sink seem to take some time to response to the output
> enable and new infoframe, so there are some delay. I've moved the HDMI
> output enable command to module load time, this helps. The infoframe
> is in theory created in run time based on the format of _each_ new
> audio stream, so infoframe transmission has to be started/stopped
> for each track..

I know this has come up before but can't we not start/stop
the infoframe if the sample format on the new track is the
same as the old. I mean playing an album, you're gonna get
44100, 2ch s16le 95% of the time so that would atleast
cause the problem to appear much less.

Shane
