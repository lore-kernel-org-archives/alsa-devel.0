From: "Shuduo Sang" <sangshuduo@gmail.com>
Subject: Re: mic doesn't work with hda-intel/AD1983 driver
Date: Wed, 29 Aug 2007 18:20:27 +0800
Message-ID: <ee101c360708290320xb19501h54531c8cc0395810@mail.gmail.com>
References: <ee101c360708280316r62a8a467l596aa6883f5dd077@mail.gmail.com>
	<s5hzm0c2bgj.wl%tiwai@suse.de>
	<ee101c360708281949s7bd4eecdn74053e9fb54b1db@mail.gmail.com>
	<s5hsl621xk8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id BAA40103936
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Aug 2007 12:20:28 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so114014nfd
	for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2007 03:20:28 -0700 (PDT)
In-Reply-To: <s5hsl621xk8.wl%tiwai@suse.de>
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

On 8/29/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 29 Aug 2007 10:49:43 +0800,
> Shuduo Sang wrote:
> >
> > $alsactl -f sound store
> > $ cat sound
> >         control.10 {
> >                 comment.access 'read write'
> >                 comment.type BOOLEAN
> >                 comment.count 2
> >                 iface MIXER
> >                 name 'Mic Playback Switch'
> >                 value.0 true
> >                 value.1 true
> >         }
>
> You should mute this.  Otherwise you'll hear the sound from mic as
> analog-loopback.
>
> >         control.15 {
> >                 comment.access 'read write'
> >                 comment.type INTEGER
> >                 comment.count 2
> >                 comment.range '0 - 3'
> >                 iface MIXER
> >                 name 'Mic Boost'
> >                 value.0 0
> >                 value.1 0
> >         }
>
> Raise this volume.

my mic works with raising mic boost volume. thanks.

>
> >         control.17 {
> >                 comment.access 'read write'
> >                 comment.type BOOLEAN
> >                 comment.count 2
> >                 iface MIXER
> >                 name 'Capture Switch'
> >                 value.0 false
> >                 value.1 false
> >         }
>
> Turn on this.  Otherwise you cannot record.
>
>
> Takashi
>
