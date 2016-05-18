From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
	error when deferring probe
Date: Wed, 18 May 2016 17:18:41 +0200
Message-ID: <209086304.1BTKYSBN0B@ws-stein>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <20160518150812.GK8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id D5CA126058D
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:18:48 +0200 (CEST)
In-Reply-To: <20160518150812.GK8104@sirena.org.uk>
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

On Wednesday 18 May 2016 16:08:12, Mark Brown wrote:
> On Wed, May 18, 2016 at 03:41:29PM +0200, Alexander Stein wrote:
> > In case there is no DAI (yet), do not print an error, this might happen
> > a lot of times. Print a notice instead.
> 
> This is changing *all* error reports which isn't OK.

Well, it's debatable if using dev_err() and then returning EPROBE_DEFER is 
correct either. IMHO if there is an actual error, an error code has to be 
returned and not "well, can't continue now, probe me again later".
At first glance those EPROBE_DEFER are correct as other dependent drivers may 
be probed later, so printing an error in that case seems wrong to me.

Best regards,
Alexander
