From: Andy Robinson <andy@seventhstring.com>
Subject: Re: Memory allocation and the "prealloc" procfile
Date: Wed, 06 Apr 2005 13:03:39 +0100
Message-ID: <1112789019.6835.30.camel@andys_dellm60.ss82amr.net>
References: <20050405192033.6B8A88993B@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050405192033.6B8A88993B@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Message: 3
> Date: Tue, 05 Apr 2005 19:16:39 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: Andy Robinson <andy@seventhstring.com>
> Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
> Subject: Re: [Alsa-devel] Memory allocation and the "prealloc" procfile
> 
> At Mon, 04 Apr 2005 10:03:37 +0100,
> Andy Robinson wrote:
> > 
> > I'm using Mandrake 10.1 on a DELL Precision M60.
> > Soundcard is Intel 82801DB-ICH4
> > ALSA version 1.0.6
> > 
> > By default, /proc/asound/card0/pcm0p/sub0/prealloc contains the number
> > 64 and SNDCTL_DSP_GETOSPACE reports a total of 16k bytes output space
> > available. If I
> > echo 128 >/proc/asound/card0/pcm0p/sub0/prealloc
> > then SNDCTL_DSP_GETOSPACE reports a total of 32k bytes.
> > 
> > My question is, what is the rest of the "prealloc" memory being used
> > for? And how can I change the amounts used for whatever other purposes,
> > so as to get a bigger SNDCTL_DSP_GETOSPACE buffer? It's not such a
> > problem for me but one of my users reports that with a 128k "prealloc",
> > he still gets only 4k from SNDCTL_DSP_GETOSPACE. Is it perhaps an ALSA
> > version issue?
> 
> It might be.  It's worth to try the latest ALSA version, anyway.
> 
> If you want a bigger buffer, you can call SNDCTL_DSP_SETFRAGMENT ioctl
> to specify the fragments and its size explicitly.
> Takashi

I will try a later ALSA version and see what happens.

But I'm still curious to know, what is all
that /proc/asound/card0/pcm0p/sub0/prealloc
memory used for? I specify 128k but only get a 32k buffer reported by
SNDCTL_DSP_GETOSPACE (and one of my users gets only 4k of buffer) ...
where is the rest going? AFAIK this prealloc file relates only to
playback and only to one specific stream.

SNDCTL_DSP_SETFRAGMENT doesn't help - it can change the way the buffer
is divided into fragments but will not increase the total
SNDCTL_DSP_GETOSPACE buffer size (e.g. it can give you twice as many
fragments, of half the size).

This problem doesn't just affect me, it affects users of my software.
Therefore I would be happier if I could find some tweak to ALSA's
configuration to fix this. I consider it more user-friendly for me to
say to them "tweak this configuration file" rather than "you must
install a later ALSA version".

Regards,
Andy Robinson, Seventh String Software, www.seventhstring.com



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
