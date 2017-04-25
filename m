From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Tue, 25 Apr 2017 08:34:15 +0530
Message-ID: <20170425030415.GV6263@localhost>
References: <20170424050144.GG6263@localhost> <s5ho9vmjmyv.wl-tiwai@suse.de>
 <s5hpog2b2o2.wl-tiwai@suse.de> <20170424091213.GO6263@localhost>
 <s5hh91eb0oc.wl-tiwai@suse.de> <20170424095244.GP6263@localhost>
 <s5hefwib075.wl-tiwai@suse.de>
 <d4e73746-40f7-8929-bdc4-5bf54aef982d@linux.intel.com>
 <20170424162738.GU6263@localhost> <s5h8tmpk66p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D3526664F
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 05:02:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8tmpk66p.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 08:32:14PM +0200, Takashi Iwai wrote:
> On Mon, 24 Apr 2017 18:27:38 +0200,
> > 
> > So we should add the remaining one byt-max98090.c as Takashi fixed
> > byt-rt5640.c one. I will send the patch for this one.
> 
> Or maybe we should replace these definitions with some macro to expand
> to the mostly same contents?  The difference is just a few callback
> functions, basically.

And while at it, I cant help but wonder but if we can do better and mark it
in platform driver thus avoiding it replication in machines. Afterall the
atomic trigger is a platform property.

Thanks
-- 
~Vinod
