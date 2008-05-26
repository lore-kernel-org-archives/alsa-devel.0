From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Surround and SPDIF on STAC9277
Date: Mon, 26 May 2008 11:15:08 -0400
Message-ID: <9e4733910805260815h50853800ic52bec769de16188@mail.gmail.com>
References: <9e4733910805241129g784fd7a2k7b33f1a154a92584@mail.gmail.com>
	<9e4733910805241402s56051579kb9e94eb1489acf17@mail.gmail.com>
	<s5hd4n9unhj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by alsa0.perex.cz (Postfix) with ESMTP id CABDD248E3
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 17:15:09 +0200 (CEST)
Received: by el-out-1112.google.com with SMTP id o28so667383ele.2
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 08:15:08 -0700 (PDT)
In-Reply-To: <s5hd4n9unhj.wl%tiwai@suse.de>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/26/08, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 24 May 2008 17:02:21 -0400,
>
> Jon Smirl wrote:
>  >
>  > I've figure out that the answer that I'm looking for is AC3 over SPDIF
>  > support. Now I'm trying to figure out how to make it work in pulse.
>
>
> If you think of real-time conversion to AC3 from linear PCM streams, I
>  guess pulseaudio doesn't support it natively.

mesilliac has got it to work. There are instructions here using the a52 plugin.
http://ubuntuforums.org/showthread.php?p=4451132

I'm running it right now on Ubuntu 64b. Flash works.

It has some issues:
 sound from VLC is broken up
 mplayer works when it uses surround51 but not with AC3 pass-through
 my stereo music is getting copied to all six channels which messes up
the processing the amp.

Getting this to work simply and reliably would be a nice feature. I
suspect most people who run SPDIF to their stereo don't realize that
they are only getting a stereo signal and they need to use something
like a52.


>
>
>  Takashi
>
>
>
>  > On 5/24/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > > How are you supposed to get 5.1 audio out of your PC? When I hook the
>  > >  SPDIF device from my STAC9227/HDA audio up to pulse, pulse says that
>  > >  the SPDIF channel only supports stereo.
>  > >
>  > >  So I go digging around the in STAC9227 datasheet.
>  > >  http://www.idt.com/?genID=STAC9227
>  > >
>  > >  STAC9227 codec only supports 192Khz SPDIF with 4/1*48Khz channels. It
>  > >  doesn't support 384Khz with 8/1*48Khz channels.
>  > >
>  > >  So there are two problems, first the existing Intel HDA/STAC9227
>  > >  driver is not exposing the 4 channel SPDIF support. Or I can't figure
>  > >  out how to get to it.
>  > >
>  > >  Second, the hardware doesn't seem to support any way to get digital
>  > >  5.1 audio out of the codec and into my Sony amp. STAC9227 does have
>  > >  six channel analog out, but my Sony amp doesn't have 6 channel analog
>  > >  in. Sony amp supports 384Khz 8-channel SPDIF in.
>  > >
>  > >
>  > >  --
>  > >  Jon Smirl
>  > >  jonsmirl@gmail.com
>  > >
>  >
>  >
>  > --
>  > Jon Smirl
>  > jonsmirl@gmail.com
>
> > _______________________________________________
>  > Alsa-devel mailing list
>  > Alsa-devel@alsa-project.org
>  > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  >
>


-- 
Jon Smirl
jonsmirl@gmail.com
