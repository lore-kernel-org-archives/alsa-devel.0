From: Andreas Mohr <andi@lisas.de>
Subject: Re: Bugs on aspire one A150
Date: Mon, 16 Mar 2009 15:50:36 +0100
Message-ID: <20090316145036.GA26358@rhlx01.hs-esslingen.de>
References: <491DBDEA.9010104@gmail.com> <492856C2.8000707@gmail.com>
	<s5hy6z9i44h.wl%tiwai@suse.de>
	<20090315092117.GA1567@rhlx01.hs-esslingen.de>
	<20090316120312.GA19299@rhlx01.hs-esslingen.de>
	<s5hocw1r7n5.wl%tiwai@suse.de>
	<20090316133001.GA8437@rhlx01.hs-esslingen.de>
	<s5hfxhdr1oz.wl%tiwai@suse.de>
	<20090316143158.GA12725@rhlx01.hs-esslingen.de>
	<s5hab7lr0k1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 7977524154
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 15:50:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hab7lr0k1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kernel Testers List <kernel-testers@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Mar 16, 2009 at 03:42:54PM +0100, Takashi Iwai wrote:
> At Mon, 16 Mar 2009 15:31:58 +0100,
> Andreas Mohr wrote:
> > 
> > Hi,
> > 
> > On Mon, Mar 16, 2009 at 03:18:20PM +0100, Takashi Iwai wrote:
> > > So, the following is also problematic
> > > 
> > > 	% arecord -fdat -c1 -Dplughw ng.wav
> > > 
> > > while the below works?
> > > 
> > > 	% arecord -fdat -Dhw good.wav
> > 
> > Indeed, the above has problems with problematic slider positions whereas
> > the below never has.
> 
> Err, could you be more specific about "slider positions"?

Hmm, I thought I was... (elsewhere)

In the problematic case (using plughw),
whenever left channel / right channel sliders are equal, no sound gets recorded.
IOW, there has to be a huge difference (in either direction)
between left and right channel slider to hear anything. And that is Not
A Good Feature to have ;)


> > > Does the conversion by sox from good.wav to a mono-channel file work?
> > 
> > I assume I should be using
> > sox good.wav -c1 good1.wav
> > ?
> > 
> > If so, yes, this works, audio is there.
> 
> Just to be sure - what about below?
> 	sox good.wav -c1 good1.wav mixer 0.5,0.5

Yep, still works.

Thanks,

Andreas
