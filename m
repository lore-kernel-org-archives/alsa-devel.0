From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Surround and SPDIF on STAC9277
Date: Sat, 24 May 2008 17:02:21 -0400
Message-ID: <9e4733910805241402s56051579kb9e94eb1489acf17@mail.gmail.com>
References: <9e4733910805241129g784fd7a2k7b33f1a154a92584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA01E24407
	for <alsa-devel@alsa-project.org>;
	Sat, 24 May 2008 23:02:22 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so1119396wag.8
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2008 14:02:21 -0700 (PDT)
In-Reply-To: <9e4733910805241129g784fd7a2k7b33f1a154a92584@mail.gmail.com>
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've figure out that the answer that I'm looking for is AC3 over SPDIF
support. Now I'm trying to figure out how to make it work in pulse.

On 5/24/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> How are you supposed to get 5.1 audio out of your PC? When I hook the
>  SPDIF device from my STAC9227/HDA audio up to pulse, pulse says that
>  the SPDIF channel only supports stereo.
>
>  So I go digging around the in STAC9227 datasheet.
>  http://www.idt.com/?genID=STAC9227
>
>  STAC9227 codec only supports 192Khz SPDIF with 4/1*48Khz channels. It
>  doesn't support 384Khz with 8/1*48Khz channels.
>
>  So there are two problems, first the existing Intel HDA/STAC9227
>  driver is not exposing the 4 channel SPDIF support. Or I can't figure
>  out how to get to it.
>
>  Second, the hardware doesn't seem to support any way to get digital
>  5.1 audio out of the codec and into my Sony amp. STAC9227 does have
>  six channel analog out, but my Sony amp doesn't have 6 channel analog
>  in. Sony amp supports 384Khz 8-channel SPDIF in.
>
>
>  --
>  Jon Smirl
>  jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
