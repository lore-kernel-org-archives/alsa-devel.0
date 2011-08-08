From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: Re: switching pcm devices dynamically when using dmix
Date: Mon, 8 Aug 2011 09:08:49 -0700
Message-ID: <CAG3SCMup3ya8NftgoYhzQM5rrMbcfEqL3xByfSGZymTHrVttmg@mail.gmail.com>
References: <CAG3SCMspSq=aVbGLwKkcp+x7syNf4a9Too+SgmQ7jJSJBH26=Q@mail.gmail.com>
	<s5hoc00f55e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34CF124554
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 18:08:53 +0200 (CEST)
Received: by yxm34 with SMTP id 34so2949468yxm.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 09:08:49 -0700 (PDT)
In-Reply-To: <s5hoc00f55e.wl%tiwai@suse.de>
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

Would it be possible to implement this feature in another plugin?  For
example, some plugin called "switch", that would take a parameter for device
or card name/number that would close the current device and open the new
requested device?  Would this be worth investigating?

Thanks!

On Mon, Aug 8, 2011 at 5:40 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 3 Aug 2011 15:13:09 -0700,
> Baek Chang wrote:
> >
> > Hi,
> >
> > I'm wondering if the following is possible.
> >
> > If I have my asound.conf configured in such a way that
> >
> > pcm.media {
> >
> > }
> >
> > route to hw:0,0 throuh dmix.
> >
> > can I dynamically change the device to hw:0,1 or hw:1,0 if necessary?
>
> Not possible with the current implementation.
> For such a purpose, better to use PulseAudio.
>
>
> Takashi
>
>


-- 
-baeksanchang
