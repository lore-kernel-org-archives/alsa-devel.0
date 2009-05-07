From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Thu, 7 May 2009 14:46:51 +0200
Message-ID: <20090507124651.GA3968@tango.0pointer.de>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AD1FD247CA
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 14:46:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbpq5s3fx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 07.05.09 10:49, Takashi Iwai (tiwai@suse.de) wrote:

> It's an old feature.  AC97 spec gives the "master" volume control only
> for front channels.  Thus, old boards with AC97 may inherit this
> policy.  (The problem of emu10k1 is partly this.)
>
> Fixing it isn't too difficult with vmaster stuff in the driver side,
> but this breaks the compatibility, and hard to find the real test
> machines nowadays.  In short, "don't touch a working system unless it
> gets broken" phase.

Breaks compatibility with what exactly? OSS? We have now disabled the
OSS compat stuff in F11 now, so I am not too concerned about
this. Also, not sure if it would be a big loss if surround sound is
only configurable with native ALSA, not OSS.

> > Can I assume that 'Master' and 'Front' are
> > always independant?
> 
> No.

May I assume that they always are dependant?

Or can't I assume anything about the relation between Master and
Front? That would suck.

> > Secondly, I have trouble supporting the
> > 'Front'/'Rear'/'Side'/... elements properly, since they split up the
> > surround channels into seperate elements. Now, this is confusing in
> > many ways, even for "amixer" which will then show channels such as
> > "Rear Front Left" and so on, which obviously make no
> > sense. snd_mixer_selem_has_playback_channel() just returns bogus data
> > for these cases. Why are those elements seperate anyway? Why aren't
> > they combined into a single multi-channel event?
> 
> That's mainly a historical reason.  In old days, there are no mixer
> apps supporting really multiple channels because the behavior of OSS.
> A stereo pair is easier to handle for apps.

Hmm. Maybe it's time to get rid of this now? As mentioned in Fedora we
now disabled OSS and didn't get any complaints about that. I mean, it
might be worth keeping compat for OSS PCM, but for the OSS mixer?

Surround sound with OSS is not really workable anyway, so I wouldn't
be too concerned to break it. 

> > Looking at the APIs I
> > get the idea that the problem appears to be that elements can only
> > control all channels the same are all independantly which doesn't
> > really match 1:1 on my multichannel sound cards. However, wouldn't it
> > be possible to use the 'index' value of a selem_id for this? I.e. have
> > a series of controls by the same name but different indexes which
> > would then implement snd_mixer_selem_has_playback_channel() correctly?
> > i.e. foo,0 would do front-left/right, foo,1 would do rear, foo,2 would
> > do lfe, and so? I have no clue how this implemented internally, so not
> > sure how feasible this might be.
> 
> This breaks the existing apps.  That's the biggest problem we face
> now.  We can't change the stuff simply because PA isn't the only app
> using that API.

Hmm, could you be more explicit which apps you think would break? I
mean, the ALSA mixer API always allowed multichannel audio, however no
driver actually made use of that. If a client is using the ALSA mixer
API properly it should not break. And if it doesn't use it properly
it's not ALSA's fault...

> IMO, the best would be a total rewrite of the current mixer API, as I
> mentioned some times.  Right now it's more complicated than needed,
> but not powerful enough to handle exceptional cases.

I certainly agree with this. But this doesn't appear to be anything
that will happen any time soon, or will it?

If we could agree to fix the surround sound situation within the
current API as far as it allows that I'd be a much happier man.

> I know designing a generic and fully-working API is pretty difficult,
> though...

That is absolutely true.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
