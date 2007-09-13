From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALSA changes in 2.6.23-rc6 for Intel HDA
Date: Thu, 13 Sep 2007 19:16:47 +0300
Message-ID: <200709131916.47518.maximlevitsky@gmail.com>
References: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
	<200709121600.42015.maximlevitsky@gmail.com>
	<9e4733910709120730y34275a5t89c38a20938d0e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id F162524392
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 18:18:16 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so767407mue
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 09:18:16 -0700 (PDT)
In-Reply-To: <9e4733910709120730y34275a5t89c38a20938d0e7e@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 September 2007 17:30:29 Jon Smirl wrote:
> On 9/12/07, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > On Tuesday 11 September 2007 19:58:00 Jon Smirl wrote:
> > > The ALSA changes in 2.6.23-rc6 for Intel HDA made me change my volume
> > > from about 30% to 75% to get the same level of sound. Was this
> > > intentional?
> > >
> > > My ALSA info is here.
> > > http://pastebin.ca/692226
> > >
> >
> >
> > Hi,
> >
> > First of all, what kernel do you compare to (which has  louder sound)
> > Then if you use headphones, maybe you plugged them in 'surround output'
> > Like center/LFE/side/surround.
> > Those outputs give much lower levers of sound.
> > Only Front HP and Line-out have special amp for headphones.
> 
> 2.6.23-rc5, I have stereo speakers plugged into the left/right output.
> I never moved the speaker plug. The volume gets louder when I load the
louder ?
> new kernel.
> 
> It looks like the name of the main PCM channel changed from 'pcm' to
> 'PCM" too. I had to reset my levels in alsamixer. I have a STAC9227.
> 
> I have everything working. It just all needed to be readjusted. Plus
> now I have to have my amp (powered speakers) set at a much higher
> level than before.
> 
> 
> >
> >
> > Best regards,
> >         Maxim Levitsky
> >
> 
> 

Hi,

It mustn't be the kernel
Last change in hda-intel code in in pre-2.6.23-rc1

by the way, PCM control is not hardware control
it is a softvol plug-in


Best regards,
	Maxim Levitsky
