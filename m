From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ALSA: core: Add 384kHz Support
Date: Wed, 27 Jan 2016 08:11:10 -0600
Message-ID: <alpine.DEB.2.10.1601270809340.3329@heelroid>
References: <1453902825-27002-1-git-send-email-brian.austin@cirrus.com>
 <s5hzivr6s0e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6376F26044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 15:07:03 +0100 (CET)
In-Reply-To: <s5hzivr6s0e.wl-tiwai@suse.de>
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
Cc: brian.austin@cirrus.com, paul.handrigan@cirrus.com, alsa-devel@alsa-project.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Jan 2016, Takashi Iwai wrote:

> On Wed, 27 Jan 2016 14:53:45 +0100,
> <brian.austin@cirrus.com> wrote:
> > 
> > From: Brian Austin <brian.austin@cirrus.com>
> > 
> > Adding support for 384kHz audio sample rates
> 
> The most important information is missing: why this is needed.
So I can specify that I want 384kHz. 
> 
> (Note that the support of 384kHz itself can be done without this
>  addition :) 
> 
So we stay at SNDRV_PCM_RATE_192000 always for sample rate defines?
And everything else is just covered with SNDRV_PCM_RATE_KNOT? 
