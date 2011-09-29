From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: dmix problems with analog out (HDMI out works fine
	with dmix)
Date: Thu, 29 Sep 2011 08:43:32 -0400
Message-ID: <CA+DpathZ=WN98qXarTysgrJPf9ysZoNHqRkA4N2uBngv8Zkytg@mail.gmail.com>
References: <CA+DpatikCTEvp59mEmfDeH=6r5=jjFyQ4jMHc-jddBZboXG=AA@mail.gmail.com>
	<s5hfwjfc0sa.wl%tiwai@suse.de>
	<CA+DpathSCpx3t3wVnX+jPufKHaZCVjiXoGF_wWozz7qPo4S3jw@mail.gmail.com>
	<s5hr52za5ry.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E62D1103A43
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:43:32 +0200 (CEST)
Received: by eyh5 with SMTP id 5so392200eyh.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:43:32 -0700 (PDT)
In-Reply-To: <s5hr52za5ry.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, Jerry Geis <geisj@messagenetsystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 29, 2011 at 8:32 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 Sep 2011 08:22:39 -0400,
> Robert Krakora wrote:
> >
> > On Thu, Sep 29, 2011 at 2:36 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Wed, 28 Sep 2011 12:29:05 -0400,
> > > Robert Krakora wrote:
> > > >
> > > > Hi All,
> > > >
> > > > I am using ALSA 1.0.24 with the attached asound.conf.  I am
> attempting to
> > > > share (mix) the analog output between Asterisk and aplay.  However,
> when
> > > > Asterisk is running, my application throws an error when attempting
> to
> > > play
> > > > a wave file via aplay.  If I stop Asterisk, aplay plays the wave file
> > > just
> > > > fine.  If I remove the asound.conf file, Asterisk and aplay are both
> > > happy
> > > > and share the analog output just find with the default ALSA dmix
> > > > implementation.  However, we need this asound.conf to work for us for
> > > other
> > > > reasons.  What is wrong with it.  I have even tried replacing dmix
> with
> > > > dshare and get the same bad behavior.  We are running CentOS 6.0.  As
> a
> > > > caveat, I am attempting to use dmix with analog audio.  If I use it
> with
> > > > HDMI audio, it works flawlessly (same asound.conf with tweek to
> specify
> > > > HDMI).  Thanks in advance for your help.
> > > >
> > > > [root@devkrakorar snd]# su silentm -c "aplay -Dplug:dmixer
> > > > /usr/share/sounds/alsa/Front_
> > > > Center.wav"
> > > > ALSA lib pcm_hw.c:1293:(snd_pcm_hw_open) open '/dev/snd/pcmC0D0p'
> failed
> > > > (-22): Invalid argument
> > > >
> > > > ALSA lib pcm_dmix.c:1068:(snd_pcm_dmix_open) unable to open slave
> > > > aplay: main:660: audio open error: Invalid argument
> > > > [root@devkrakorar snd]#
> > >
> > > Looks like the open of HD-audio stream failed by some reason.
> > > When you open via aplay, is the corresponding stream already opened
> > > by another?  Take a look at /proc/asound/card0/pcm0p/sub0/* files.
> > >
> > > Also, try the latest alsa-driver snapshot in
> > >   ftp://ftp.suse.com/pub/people/tiwai/snapshot/
> > >
> > >
> > > Takashi
> > >
> >
> > Hi Takashi,
> >
> > Thanks for the quick response.  Yes, the HD-audio stream open fails
> because
> > Asterisk has previously opened it.  aplay cannot open it (error -22).
>
> -22 is -EINVAL, and it's not -EBUSY or -EAGAIN.  If a blocking open is
> the problem, it should have been -EAGAIN or such.
> That is, usually something conflicts with the opened stream.
>
>
> Takashi
>

Hi Takashi,

You are the man!  Your latest drivers have eliminated this issue!  What did
you have to change to fix this?

Best Regards,

-- 
Rob Krakora
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext 212
(317)663-0808 Fax
