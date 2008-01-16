From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: TLV support for PCM (in driver)
Date: Wed, 16 Jan 2008 16:19:35 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801161602320.7446@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0801161504450.7446@tm8103.perex-int.cz>
	<s5hfxwxvn9r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 86873244D9
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 16:19:36 +0100 (CET)
In-Reply-To: <s5hfxwxvn9r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Jan 2008, Takashi Iwai wrote:

> At Wed, 16 Jan 2008 15:23:37 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	I am actually thinking to add TLV support to each PCM stream. The 
> > reason is to obtain various "static" information from the driver without 
> > even opening the PCM stream. The current API lack:
> > 
> > a) get channel info / name / position (e.g. Front Left Speaker)
> >    - not sure how to handle multichannel cards
> 
> This won't work with the static TLV because the channel mapping is a
> dynamic information.  It varies depending on the hw_params setting.
> A typical difference is the mappings between 4 and 6 channels
> (FL/FR/RL/RR and FL/FR/C/LFE/RL/RR).
> 
> >    - I'm sure that this is something to be user configurable
> 
> Everything is user-configurable :)
> 
> But the channel mapping is basically bound to the driver
> implementation, so rather there is no real user-configuration, AFAIK.
> 
> I've already hacked to extend channel_info to include this
> information.  If you're interested, I'll post patches.
> 
> > b) get possible channels
> > c) get possible formats
> 
> These *could* be dynamic, too.  That's why we have a complex hw_params
> procedure.  But, they are static for most cases, so it would likely
> work.

Ok, I didn't explain the term "static" as well. I think that the best way 
might be to group parameters like:

parameters #1 {
	channels {
		2 { FL, FR }
		4 { FL, FR, RL, RR }
		6 { FL, FR, C, LFE, RL, RR }
	}
	formats {
		S16_LE, S32_LE
	}
}
parameters #2 {
	....
}

Just idea. We can get this change as base to change from refine method to 
provide a list of possible values method and reduce the kernel and 
alsa-lib code.

> > d) various inter-PCM-device constraint description (e.g. if S/PDIF 
> >    PCM stream can be used with analog etc.)
> 
> This sounds good.  Any practical use in mind?

I think that Lennart Poettering requirested this and I think that it might 
make sense for various TV Linux boxes ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
