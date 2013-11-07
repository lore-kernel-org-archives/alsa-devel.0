From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Thu, 7 Nov 2013 10:19:39 +0000
Message-ID: <20131107101939.GJ30879@opensource.wolfsonmicro.com>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-14-git-send-email-tiwai@suse.de>
 <20131106184422.GI30879@opensource.wolfsonmicro.com>
 <s5hk3gle0tt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8097C2654EF
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 11:19:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk3gle0tt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 06, 2013 at 09:23:42PM +0100, Takashi Iwai wrote:
> At Wed, 6 Nov 2013 18:44:22 +0000,
> Charles Keepax wrote:
> > These do make me a little nervous previously we would panic here,
> > so everything would stop but now we may write random registers on
> > the CODEC which could cause some odd behaviour. I think it would
> > be better to update wm_adsp_region_to_reg to allow a failed
> > return code and then error out of wm_adsp_load rather than just
> > relying on the WARN_ON inside.
> 
> Yeah, handling the error properly would be definitely better.
> Care to enhance the patch?

Yeah fair enough, lets merge the patch as is and I will send out a
seperate patch once I get a few spare minutes to improve the
error handling in this bit of code.

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
