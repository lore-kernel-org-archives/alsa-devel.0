From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: compress: Add DSP private metadata
 interface
Date: Tue, 23 Feb 2016 08:39:31 -0600
Message-ID: <56CC6F23.6090705@linux.intel.com>
References: <1456163671-40987-1-git-send-email-tim.sheridan@imgtec.com>
 <s5h8u2b22op.wl-tiwai@suse.de> <20160223094223.GK17690@localhost>
 <98E3058E5505294895CA69F176CAD6626A6D8BE1@LEMAIL01.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CFB4260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 15:39:36 +0100 (CET)
In-Reply-To: <98E3058E5505294895CA69F176CAD6626A6D8BE1@LEMAIL01.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Sheridan <Tim.Sheridan@imgtec.com>, 'Vinod Koul' <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Neil Jones <neil.jones@imgtec.com>
List-Id: alsa-devel@alsa-project.org


> AXD's got various features which require mode setting (e.g. for
> selecting between multi-device synchronization mechanisms that it
> supports). This would need an enum control, but I guess that this
> could be fudged with mutually exclusive switch controls for each of
> the enum values. AXD's also got numeric configuration parameters
> which it needs to be able to receive (e.g. parameters for stream
> synchronization heuristics, audio filter coefficients, etc.). Maybe a
> volume control with a domain wide enough could be used for this kind
> of configuration parameter. It's rather horrible, but might be fine
> for while the AXD driver is out of tree and there aren't more
> appropriate ALSA control types (e.g. enum and non-volume integer).
> :-/

I am not too sure I understand what you refer to as synchronization or 
multi-device synchronization mechanisms. Since you mentioned you only 
need an initial time, I wonder if this is conceptually related to the 
start_at() functionality discussed last year for PCM?

If you have a set of implementation-defined mechanisms related to 
algorithms, why not use an ALSA binary control where you define you own 
syntax and content and use the alsa control layer as a 'dumb' pipe 
between user and kernel. That's what everyone does for DSP control.
