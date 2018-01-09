From: "Francisco G." <frangio.1@gmail.com>
Subject: Re: snd_hda_intel: coil whine noises after resume
Date: Tue, 9 Jan 2018 12:10:51 -0300
Message-ID: <CAHXyb9aQxyJRtMMWnd9NU1WJzxy+n6Pe7-6FEjM_fvv+hsbDfg@mail.gmail.com>
References: <CAHXyb9ZCZJzVisuBARa+UORcjRERV8yokez=DP1_5O5isTz0ZA@mail.gmail.com>
 <s5hbmi31lag.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f193.google.com (mail-yb0-f193.google.com
 [209.85.213.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1AA266E45
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 16:11:08 +0100 (CET)
Received: by mail-yb0-f193.google.com with SMTP id 65so1914368ybz.6
 for <alsa-devel@alsa-project.org>; Tue, 09 Jan 2018 07:11:08 -0800 (PST)
In-Reply-To: <s5hbmi31lag.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi. Here's the output: https://pastebin.com/z9uFY8Zt

The SSID seems to be 1028:082a.

On Tue, Jan 9, 2018 at 5:36 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 08 Jan 2018 00:07:55 +0100,
> Francisco G. wrote:
> >
> > Hello.
> >
> > Some users included myself have noticed coil-whine-like noises coming
> > through the headphones after the computer resumes from sleep. This noise
> is
> > clearly associated to the laptop activity, e.g. when scrolling through a
> > webpage or compiling something, the processor can be heard doing the
> work.
> >
> > Interestingly, the coil whine that can be heard from the computer with
> > naked ears (which is a common problem with this laptop) is also increased
> > after resume.
> >
> > The problem has been observed on a Dell XPS 13 9360 with an i7-8550U CPU
> by
> > myself, as well as with an i5-8250U by a user in the Arch Linux forums
> > <https://bbs.archlinux.org/viewtopic.php?pid=1759588#p1759588>. This
> user
> > has also noticed that reloading the snd_hda_intel module fixes the issue.
> >
> > Please let me know of any inormation that would be needed to debug this
> > problem.
>
> A few XPS13/15 models have the workaround for such issues.  They are
> applied per PCI SSID matching, so your model might be missing there?
> 1028:05fe, 1028:060a and 1028:060d are matched, so far.  But it's for
> ALC662 variant, and the recent machine may have a different codec,
> too...
>
> In anyway, the hardware detail information is missing.  Please give
> the output of alsa-info.sh (run with --no-upload option).
>
>
> Takashi
>
