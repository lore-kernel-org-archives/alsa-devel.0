From: Tim Sheridan <Tim.Sheridan@imgtec.com>
Subject: Re: [PATCH] ALSA: compress: Add DSP private metadata
 interface
Date: Tue, 23 Feb 2016 15:40:29 +0000
Message-ID: <98E3058E5505294895CA69F176CAD6626A6D90F7@LEMAIL01.le.imgtec.org>
References: <1456163671-40987-1-git-send-email-tim.sheridan@imgtec.com>
 <s5h8u2b22op.wl-tiwai@suse.de> <20160223094223.GK17690@localhost>
 <98E3058E5505294895CA69F176CAD6626A6D8BE1@LEMAIL01.le.imgtec.org>
 <56CC6F23.6090705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB04260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 16:40:32 +0100 (CET)
In-Reply-To: <56CC6F23.6090705@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>, 'Vinod
 Koul' <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Neil Jones <neil.jones@imgtec.com>
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

> I am not too sure I understand what you refer to as synchronization or multi-
> device synchronization mechanisms. Since you mentioned you only need an
> initial time, I wonder if this is conceptually related to the
> start_at() functionality discussed last year for PCM?

Yup, it is related to the start_at() functionality. Before start_at() playback can happen, the AXD DSP must be switched into the start_at mode.

> If you have a set of implementation-defined mechanisms related to
> algorithms, why not use an ALSA binary control where you define you own
> syntax and content and use the alsa control layer as a 'dumb' pipe between
> user and kernel. That's what everyone does for DSP control.

Ah, thanks very much for that advice. This looks like a good option (looking how it's being done for filter parameters in sound/soc/intel/atom).

Cheers,
Tim
