From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: power save of snd_hda_intel
Date: Wed, 28 May 2008 18:57:30 +0530
Message-ID: <827ad74d0805280627h4aee4631sea6634d5be77a4d9@mail.gmail.com>
References: <827ad74d0805280609p8420727gcf08dd557a52ae5a@mail.gmail.com>
	<s5hk5hepnv9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 026CD24655
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 15:27:32 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3425966wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 06:27:31 -0700 (PDT)
In-Reply-To: <s5hk5hepnv9.wl%tiwai@suse.de>
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

This is what we tried;
1. Connected the system with ALC262 card to DAQ to get power measurements
2. With Linux HDD, we installed the snd_intel_hda module.
3. From ALSA .15 version, if am not wrong, power_save is enabled by default.
4. We open a media player and play the song. The power is high. After the
song stops we close the player and see that the power is still high and
power does not drop down.
5. With windows HDD, on playing a song we see the power is high. After the
music stops and player is closed, the power falls down

On Wed, May 28, 2008 at 6:49 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 28 May 2008 18:39:42 +0530,
> Harsha priya gupta wrote:
> >
> > Hi,
> >
> > I am trying to get a power_save option of snd_hda_intel working.
> > We are using latest ALSA build and ALC262 codec. when we start the player
> > and close it, we dont see any power savings. [ We see the power saving in
> > windows with the same ALC262 card]
> >
> > Any idea what i could be doing wrong here?
>
> How did you try it exactly?
>
>
> Takashi
>



-- 
-Harsha
