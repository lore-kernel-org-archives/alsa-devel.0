From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Help wanted: emachines em350 internal mic
Date: Tue, 7 Dec 2010 11:43:32 +0800
Message-ID: <AANLkTikHW73J1PEnwdA+xbniE=E77A8tPQ=f2px6CO+R@mail.gmail.com>
References: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
	<4CFDA5FF.6060403@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FDFE103945
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 04:43:38 +0100 (CET)
Received: by ewy1 with SMTP id 1so7232848ewy.29
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 19:43:33 -0800 (PST)
In-Reply-To: <4CFDA5FF.6060403@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/7 Eliot Blennerhassett <linux@audioscience.com>

> Thanks Raymond,
>
> On 03/12/10 15:33, Raymond Yau wrote:
> >>> Greetings,
> >
> >
> >>> There is only a single mic on this netbook. However, the alsa device
> >>> shows up as stereo, and the right channel carries an inverted copy of
> >>> the left channel.
> >
> >
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=59c774ed5ee00e9623a204c3234191d6a6d8cf7a
>
> Commitlog was "Add route_policy copy to HDA-Intel.conf for capture
> Since some digital mics have the phase-inversion problem in one channel,
> adding both channels for mono stream results in the noise. Use
> route_policy copy to avoid that situation."
>
> As far as I can guess, the commit helps when an application asks to
> record mono from the stereo device, by copying L rather than summing L+R
>
> My machine already has this, however it doesn't really fix the root of
> the problem.
>

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/639846

The route plugin is only used when the application are alsa 's default
pcm/ctl device for hda-intel if you fall back to use dmix/dsnoop


pulseaudio is using front device for capturing (i.e. changing PCM Playback
volume affect pulseaudio recording )


>
> Because the internal mic appears as a stereo device, rather than a mono,
> applications can open it as stereo.
>
> Only later when the resulting signal L+R is sent to a mono output does
> the signal "disappear".
>
> So I'm back to wondering how to force an app (primarily PulseAudio) to
> see the mic as mono?
>
>
you have to ask PA developer
