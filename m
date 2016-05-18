From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
	error when deferring probe
Date: Wed, 18 May 2016 17:50:50 +0200
Message-ID: <1574831.WL8kGhHEjA@ws-stein>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <209086304.1BTKYSBN0B@ws-stein> <20160518152820.GN8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 6E91E260647
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:51:55 +0200 (CEST)
In-Reply-To: <20160518152820.GN8104@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 18 May 2016 16:28:20, Mark Brown wrote:
> On Wed, May 18, 2016 at 05:18:41PM +0200, Alexander Stein wrote:
> > Well, it's debatable if using dev_err() and then returning EPROBE_DEFER is
> > correct either. IMHO if there is an actual error, an error code has to be
> > returned and not "well, can't continue now, probe me again later".
> > At first glance those EPROBE_DEFER are correct as other dependent drivers
> > may be probed later, so printing an error in that case seems wrong to me.
> Half the point with probe deferral is that it's transparent to anything
> that isn't actually resolving a resource - if we have to add custom code
> in to everywhere were we need to print an error in a probe path that's
> not great either.  We also don't want to silently ignore probe deferral
> all the time since then it becomes very hard to diagnose why something
> is not instantiating.

I came up with this because on one of our boards there are lots of probe 
deferals, mainly caused by i2c gpio expanders and audio. Anyway, in order to 
reduce boot time I silence the boot console using 'quiet' on command line. 
Nevertheless It's quite useless to have several error (!) messages during boot 
just caused by probe deferral. Here is one bootup. It's from an old vendor 
kernel, but you get the idea.

> Starting kernel ...
>
> [    5.490931] i2c i2c-0: of_i2c: modalias failure on
> /soc/i2c@2180000/cyusb3314@60 init started: BusyBox v1.22.0 (2015-10-13
> 14:03:10 CEST)
> starting pid 122, tty '/dev/console': '/etc/init.d/rcS'
> [    6.533391] vf610-sgtl5000 sound.9: ASoC: CPU DAI (null) not registered
> [    6.571234] vf610-sgtl5000 sound.9: ASoC: CPU DAI (null) not registered
> [    6.586243] vf610-sgtl5000 sound.9: ASoC: CPU DAI (null) not registered
> [    6.598094] vf610-sgtl5000 sound.9: ASoC: CPU DAI (null) not registered
> starting pid 238, tty '/dev/console': '/sbin/getty -L 115200 ttyS0 vt102'
> 
> ecucore login:

My first idea was to use dev_dbg() but that actualy remove that message at 
all, unless dynamic debug is used, so I went with dev_notice. It's still 
there, but does not clobber quiet boot log, nor some sophisticated kernel log 
parser as journalctl which prints errors in red color.

Best regards,
Alexander
