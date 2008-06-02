From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: hda intel - power save - need more help
Date: Mon, 2 Jun 2008 15:44:08 +0530
Message-ID: <827ad74d0806020314h46cf4661jddde377da3c0a66f@mail.gmail.com>
References: <827ad74d0806012345w181a69c0n7cff807d7f763577@mail.gmail.com>
	<s5h8wxob8dt.wl%tiwai@suse.de>
	<827ad74d0806020237k49c67e1eq1ccc0cee70338450@mail.gmail.com>
	<s5hod6k9ns9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 468AB103873
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 12:14:09 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so249104and.80
	for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2008 03:14:08 -0700 (PDT)
In-Reply-To: <s5hod6k9ns9.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

using the hildon desktop, there is just one control exposed of volume/mute.
i muted that and still no luck. Any other idea that that i can try?

On Mon, Jun 2, 2008 at 3:11 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Jun 2008 15:07:49 +0530,
> Harsha priya gupta wrote:
> >
> > I verified the value of /sys/modules/snd_hda_intel/parameters/power_save
> to be
> > 10.
> >
> > How can i ensure that the analog switches are off? Through Kmix?
>
> Any sane mixer apps you like.  But note that some mixer apps are buggy
> and don't show all mixer components.
>
>
> Takashi
>
> >
> > On Mon, Jun 2, 2008 at 1:01 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Mon, 2 Jun 2008 12:15:06 +0530,
> >     Harsha priya gupta wrote:
> >     >
> >     > I checked on these articles on powertop...i manually set it the
> value to
> >     10
> >     > for *POWER_SAVE_DEFAULT but still don't see any power saving...
> >
> >     Check whether it's really set to 10 in
> >     /sys/modules/snd_hda_intel/parameters/power_save.
> >
> >     Also, the power-save is turned on only when all analog loopback
> >     switches are off, e.g. Mic Playback Switch or Beep Playback Switch
> >     must be off.  Otherwise the analog part must be powered on.
> >
> >     Takashi
> >
> > --
> > -Harsha
> >
> >
>



-- 
-Harsha
