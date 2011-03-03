From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
 CS4207 only
Date: Thu, 03 Mar 2011 17:50:22 +0530
Message-ID: <1299154822.5858.12.camel@snowflake>
References: <1298955969.12314.12.camel@snowflake>
	<1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
	<1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
	<s5hfwr4jtuw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 3082F103832
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 13:20:19 +0100 (CET)
In-Reply-To: <s5hfwr4jtuw.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-03 at 13:01 +0100, Takashi Iwai wrote:
> At Thu,  3 Mar 2011 03:18:18 +0530,
> Arun Raghavan wrote:
> > 
> > From: Arun Raghavan <arun@accosted.net>
> > 
> > The commit a769cbcf60cee51f4431c0938acd39e7e5b76b8d
> >     ALSA: hda - Add errata initverb sequence for CS42xx codecs
> > applies a fix for a chip erratum that is specific to CS4207
> > unconditionally. On CS4206, this causes digital output to never be
> > activated.
> 
> It might be the power-state the verb table sets?
> Try to comment out only the line setting SPDIF Tx to D3,
>   {0x08, AC_VERB_SET_POWER_STATE, 0x03}
> instead of disabling the whole verbs, just for testing.

Indeed, this also works.

-- Arun
