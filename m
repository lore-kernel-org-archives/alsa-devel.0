From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: Add DSP private metadata
 interface
Date: Tue, 23 Feb 2016 21:37:54 +0530
Message-ID: <20160223160754.GL17690@localhost>
References: <1456163671-40987-1-git-send-email-tim.sheridan@imgtec.com>
 <s5h8u2b22op.wl-tiwai@suse.de> <20160223094223.GK17690@localhost>
 <98E3058E5505294895CA69F176CAD6626A6D8BE1@LEMAIL01.le.imgtec.org>
 <56CC6F23.6090705@linux.intel.com>
 <98E3058E5505294895CA69F176CAD6626A6D90F7@LEMAIL01.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C48A4260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 17:04:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98E3058E5505294895CA69F176CAD6626A6D90F7@LEMAIL01.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Sheridan <Tim.Sheridan@imgtec.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>, Neil Jones <neil.jones@imgtec.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2016 at 03:40:29PM +0000, Tim Sheridan wrote:
> Hi Pierre-Louis,
> 
> > I am not too sure I understand what you refer to as synchronization or multi-
> > device synchronization mechanisms. Since you mentioned you only need an
> > initial time, I wonder if this is conceptually related to the
> > start_at() functionality discussed last year for PCM?
> 
> Yup, it is related to the start_at() functionality. Before start_at() playback can happen, the AXD DSP must be switched into the start_at mode.
> 
> > If you have a set of implementation-defined mechanisms related to
> > algorithms, why not use an ALSA binary control where you define you own
> > syntax and content and use the alsa control layer as a 'dumb' pipe between
> > user and kernel. That's what everyone does for DSP control.
> 
> Ah, thanks very much for that advice. This looks like a good option (looking how it's being done for filter parameters in sound/soc/intel/atom).

Also please note that we can now avoid hard coding these in kernel. You can
define a topology graph for DSP and use alsa topology to create a topology
binary which is loaded by driver and passed to ASoC topology core which
creates these elements as well as DAPM graph

This way you can change graphs and customize them very easily!

Thanks
-- 
~Vinod
