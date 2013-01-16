From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Wed, 16 Jan 2013 09:52:10 +0800
Message-ID: <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF742616B2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 02:52:12 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id c11so1528132ieb.33
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 17:52:11 -0800 (PST)
In-Reply-To: <20130115095325.7aa2dfdd@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, basinilya@gmail.com, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> >>
> >> >Yes, testing the latest code with real machines is highly
> >> >appreciated.  Try sound-unstable git tree, either master or
> >> >test/hda-migrate branch.
> >> >  git://
git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
> >> >
> >> >Alternatively you can build the external alsa-driver modules from
> >> >alsa-driver-unstable snapshot tarball, too
> >> >
> >
ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> >> >
> >> >Note that only the behavior of model=auto has been changed in the tree
> >> >above.  The other model behaviors of AD codecs are unchanged at all.
> >>
> >> Mixer crashes are gone. As I wrote I have no way to test the digital
> >> output.
> >>
> >> I haven't found a way to test multi stream playback either. After
> >> choosing HP Independant enabled I can't hear nothing through the
> >> headphone.
> >>

Did audio work with suspend and resume since my p5b-v ad1988 cannot suspend
/ resume anymore after install Ubuntu 12.04 ?

Audio can suspend / resume in fedora 10 for different version of alsa
driver

Seen many ad1988 controls are missing ?

1) rear Mic, line , front Mic  playback volume and switch
2) CD playback switch
3) input mix in input source
4) analog loopback mix volume and mute switch
