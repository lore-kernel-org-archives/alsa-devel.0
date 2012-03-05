From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 05 Mar 2012 17:05:12 +0000
Message-ID: <1330967112.4370.23.camel@odin>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
	<1330958882.4370.15.camel@odin>
	<20120305152616.GS3224@opensource.wolfsonmicro.com>
	<1330962910.4370.21.camel@odin>
	<20120305164532.GU3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 207F01043CA
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 18:05:32 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so2731189wib.13
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 09:05:14 -0800 (PST)
In-Reply-To: <20120305164532.GU3224@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-03-05 at 16:45 +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 03:55:10PM +0000, Liam Girdwood wrote:
> 
> > PCM ops and DAPM don't fight with each other, there is a dependency with
> > the snd_card->control_rwsem. The calling ordering is different for init
> > that it is for kcontrol updates that causes the warning below :-
> 
> control_rwsem isn't in mainline...

Sorry, my typo controls_rwsem. Mostly used in sound/core/control.c
