From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Mon, 6 Aug 2012 14:07:51 +0100
Message-ID: <20120806130751.GI16861@opensource.wolfsonmicro.com>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
 <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
 <20120802180926.GL4537@opensource.wolfsonmicro.com>
 <s5h1ujkmotf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 050AE265279
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 14:38:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1ujkmotf.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, ramesh.babu@intel.com, namartax.kohli@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 10:01:32AM +0200, Takashi Iwai wrote:

> of snd_pcm_stream_lock*().  But before adding it, we should revisit
> the current lock mess in the code...

Yes, simplifying the locking scheme would be really helpful all round.
