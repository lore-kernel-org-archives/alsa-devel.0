From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: HDA NIDs 0x25 & 0x26 on ALC883
Date: Wed, 16 Jan 2008 14:56:08 -0500
Message-ID: <76366b180801161156r5f628f4bsc49500bff0fd15f7@mail.gmail.com>
References: <76366b180801151514n60248020tdac0e37bef67494@mail.gmail.com>
	<s5hve5uug8u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 442032456A
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 20:56:10 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so263026nzf.2
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 11:56:08 -0800 (PST)
In-Reply-To: <s5hve5uug8u.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Do you have any thoughts on the second part? I'm not getting the same
quality audio out of each of the ports, and I'm not sure where to
look. I see everything from the chipset being dumped in the /proc
codec file, and nothing appears different between the mixers/pins. Are
there any other settings which could be different? I tested using
aplay. It plays the audio out of all the output jacks and it is
audibly different just using a pair of headphones.

Thanks,
-Andrew

On Jan 16, 2008 7:06 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 15 Jan 2008 18:14:52 -0500,
> Andrew Paprocki wrote:
> >
> > Takashi,
> >
> > Do you know anything about NIDs 0x25 and 0x26 on the ALC883 chip? 0x25
> > is an Audio Output and 0x26 is an Audio Mixer. They appear completely
> > separate from the 0x0c-0x0f mixers, but when I map one of my pins to
> > use the 0x26 mixer, I hear audio over the jack whenever I play to the
> > standard 'Green' 0x0c mixer. The 0x26 mixer seems unused in the
> > current driver, so I'm not sure if there is something special about
> > it. I'm basically trying to use it as a 5th output.
> >
> > Also, when I play audio, the 0x0c mixer has a nice full sound (the
> > "expected" sound). The 0x0d & 0x0e mixers have much less bass and
> > sound like someone turned up the treble. The 0x0f and 0x26 mixers have
> > an even more "tinny" sound. I've verified that all the mixers/pins are
> > configured the same exact way and all have full volume (0x1f). Do you
> > know of any reason why the audio output over the pins would differ?
> > I'm not sure what I could be missing here to get them to all sound the
> > same.
>
> This kind of individual DAC/ADC is provided for the independent
> streams, such as, using VoIP during playing DVD.
>
> We don't create PCMs for such streams yet.  I'm sure that wouldn't be
> hard to implement, but I've ben too lazy :)
>
>
> Takashi
