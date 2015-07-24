From: Woodrow Shen <woodrow.shen@canonical.com>
Subject: Re: [PATCH v1] ALSA: hda- Add headset mic pin quirk
 for a Dell device
Date: Fri, 24 Jul 2015 17:39:24 +0800
Message-ID: <CAFd7sfVb=+fu5txHnF-zmGPFo0amB-Giyr5hvc-25KOH8eTWpQ@mail.gmail.com>
References: <1437713442-6061-1-git-send-email-woodrow.shen@canonical.com>
 <s5hio9avyen.wl-tiwai@suse.de> <55B1E5FB.1080702@canonical.com>
 <s5hd1zivvs6.wl-tiwai@suse.de> <55B1F14A.1080106@canonical.com>
 <s5ha8umvuhb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 875A1260558
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 11:39:25 +0200 (CEST)
Received: by obnw1 with SMTP id w1so12893624obn.3
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 02:39:24 -0700 (PDT)
In-Reply-To: <s5ha8umvuhb.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and David,

Thanks your suggestions, i'll describe more details for this patch and send
it again.

Woodrow

On Fri, Jul 24, 2015 at 4:18 PM, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 24 Jul 2015 10:03:22 +0200,
> David Henningsson wrote:
> >
> >
> >
> > On 2015-07-24 09:50, Takashi Iwai wrote:
> > > On Fri, 24 Jul 2015 09:15:07 +0200,
> > > David Henningsson wrote:
> > >>
> > >>
> > >>
> > >> On 2015-07-24 08:54, Takashi Iwai wrote:
> > >>> On Fri, 24 Jul 2015 06:50:42 +0200,
> > >>> woodrow.shen@canonical.com wrote:
> > >>>>
> > >>>> From: Woodrow Shen <woodrow.shen@canonical.com>
> > >>>>
> > >>>> Fix the headset mic that will not work on Dell desktop machine.
> > >>>> BugLink: https://bugs.launchpad.net/bugs/1475553
> > >>>> Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
> > >>>
> > >>> I have repeatedly received patches with the very same subject and
> with
> > >>> the very similar content but without further explanation.  It's too
> > >>> confusing.
> > >>>
> > >>> Please look through the git commit history of this file, and re-read
> > >>> your patch.  Then, consider a more useful subject / description, and
> > >>> resubmit the patch.
> > >>
> > >> Hi Takashi,
> > >>
> > >> We're doing enablement of machines and several of them need pin quirks
> > >> in order to have the headset mic working. Since these machines are
> > >> pre-release, we are not allowed to make the final name of the machine
> > >> public (e g, "Dell XPS 13"). For the same reason, we cannot give you
> > >> alsa-info either.
> > >>
> > >> Given this constraint, how do you suggest we improve the subject /
> > >> description? Or should we wait to submit upstream until the machine
> has
> > >> been released to the market?
> > >
> > > I don't mean to give alsa-info.sh output or such.  The problem is that
> > > it's always with the same subject and the same text.  How do you know
> > > it's for what and apply in which order?
> > >
> > > At least you should try the patch looks different with each other,
> > > describe the relationship with previous commits, etc.
> >
> > Right, so merely change the semantics, like "One more headset quirk",
> > "Yet another headset quirk", "a totally splendid headset quirk", "oh
> > look it's a headset quirk", "a headset quirk for a sunny day", and so on?
>
> Even that is better than the current form.  You can mention which
> patch is the second patch that should be applied after which commit.
> Or, you can give a bit more specific information like the codec name.
> And you can name the difference of pincfgs from others.  We need to
> know *why* this change is needed.
>
> > The relationship with previous commits is that they fix the same problem
> > for different machines, so they're usually independent of each other.
>
> But it is: you cannot apply the patch cleanly if you don't follow the
> order.
>
>
> thanks,
>
> Takashi
>



-- 
Regards,
Woodrow
