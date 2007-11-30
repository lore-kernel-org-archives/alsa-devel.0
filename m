From: "John Utz" <john.utz@dmx.com>
Subject: Re: Softvol controls
Date: Thu, 29 Nov 2007 16:34:48 -0800
Message-ID: <20071129163448.439523b0@jutz-gnto64>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
	<20071129232859.GA18138@tango.0pointer.de>
	<20071129154657.2a7a2be1@jutz-gnto64>
	<20071130000810.GA20465@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A15DD24396
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 01:35:08 +0100 (CET)
In-Reply-To: <20071130000810.GA20465@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oh heck.....

On Fri, 30 Nov 2007 01:08:11 +0100
"Lennart Poettering" <mznyfn@0pointer.de> wrote:

> On Thu, 29.11.07 15:46, John Utz (john.utz@dmx.com) wrote:
> 
> John,
> 
> > > > Check snd_ctl_elem_info_is_user().  All softvol controls are
> > > > implemented as user elements.
> > > 
> > > Hmm, how am I supposed to get the snd_ctl_elem_info_t from a
> > > snd_mixer_elem_t or snd_mixer_selem_id_t?
> > > 
> > > I figure there is no useful documentation or even example how
> > > this is supposed to work? Hmm, is there any real documentation
> > > available which describes the relation of ctl, hctl, mixer and
> > > smixer at all? For the uninitated the whols structure looks
> > > overly complex and redundant.
> > 
> > Here's my take on it....HTH
> > 
> > dont hesitate to ask
> 
> Hu? Neither "snd_ctl_elem_info_t" nor "snd_ctl_elem_info_is_user()"
> is even mentioned in your source code excerpt?

I failed to pay close enuf attention to your post. sorry 'bout that.

> I know how to change volumes and stuff via the ALSA mixer API. What I
> am looking for is a way to detect whether a mixer element is
> implemented in softwaer only and thus doesn't influence your ouput
> when you open a PCM device with "hw:0", "front:0", "surround51:0" and
> suchlike.

That actually is a good question that i thought i might have to answer,
but i managed to avoid it.

Sorry for the confusion.....

johnu

> Lennart
> 
