From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: In 3.8 kernel alsa only talks HDMI,
 hardware also has S/PDIF optical
Date: Tue, 12 Mar 2013 15:26:03 +0800
Message-ID: <CAN8cciZyjmKYS+VaxW4xLC4i_r5_RddRUa7UHf4XizkJKcwH4w@mail.gmail.com>
References: <20130311191801.035a7e29@zooty>
	<s5hy5dtksbv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B99F02615D6
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 08:26:05 +0100 (CET)
Received: by mail-ie0-f170.google.com with SMTP id c11so5991797ieb.15
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 00:26:04 -0700 (PDT)
In-Reply-To: <s5hy5dtksbv.wl%tiwai@suse.de>
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
Cc: Tom Horsley <horsley1953@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > On my Asus P8H67-V there really are two physically
> > separate audio outputs. I have the optical port
> > connected to my receiver for when I want to pass
> > through the 5.1 audio tracks in movie files and
> > DVDs and the HDMI connected to the TV for more
> > ordinary audio (error beeps from the computer, etc).
> >
> > In kernel 3.7.9 I could output to both devices
> > (one at a time - never tried simultaneous).
> >
> > I've seen a bunch of patches in the archives that seem
> > to be related to this, but if fedora 18 has those patches,
> > they don't seem to be working.
>
> This is an intended change, considered as a "fix" for the formerly
> broken state.  The combination of SPDIF + HDMI has never been working
> properly because of conflicting control elements assignment.  (You may
> say that "it worked for me!", but it doesn't count it gets used right
> :)
>
> For fixing it, one of them has to be victimized.  Now IEC958 control
> element of SPDIF is shifted to the lone safe place for the sake of
> HDMI, which has more users than SPDIF, being persistent.
>
> Updating alsa-lib configuration from alsa-lib git tree should correct
> the usage of ICE958 control index for SPDIF devices.  Hopefully we'll
> get alsa-lib release sometime later...
>
>

Is IEC958 Default PCM Playback Switch specific for analog codec's spdif ?

control.32 {
iface MIXER
name 'IEC958 Default PCM Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
