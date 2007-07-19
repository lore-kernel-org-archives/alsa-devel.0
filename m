From: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Subject: Re: dmix and sounds less than 64kb
Date: Thu, 19 Jul 2007 12:59:32 -0700
Message-ID: <61e8390b0707191259y5f77fb46jabed4184491ea5a4@mail.gmail.com>
References: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
	<s5hir8tvrvt.wl%tiwai@suse.de>
	<61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
	<Pine.LNX.4.61.0707100954280.7300@tm8103.perex-int.cz>
	<61e8390b0707100104v9e66c8fu1321c287d1b8ed5e@mail.gmail.com>
	<Pine.LNX.4.61.0707101008440.7300@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CFA12436A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 21:59:33 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so500038ugf
	for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2007 12:59:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0707101008440.7300@tm8103.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We have found that the problem exists because, at certain points in time,
the hardware pointer and application pointer overlap. Basically the hardware
is reading from the period buffer which is currently being written to. How
might this be platform specific? Is there any debugging technique you think
may help find the root cause?

On 7/10/07, Jaroslav Kysela <perex@suse.cz> wrote:
>
> On Tue, 10 Jul 2007, Aaron "Caustik" Robinson wrote:
>
> > This is on an embedded ARM device, with a custom driver. That's
> > interesting. I never thought about the cache angle. Is there any sort of
> > hack I can put to check if that is the problem?
>
> The cache flush method is quite CPU specific, you have to check datasheet.
> But it's only guess and the problem might be somewhere else. I would
> compare samples DMA ring buffer in the user space and kernel space again.
> Also, put a debug lines to dmix plugin to detect where are samples written
> (to which pointer/area in the DMA ring buffer). dmix assumes that playback
> is running forever and tries to mix data in actual ring buffer position.
>
>                                                 Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>
