From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dB gain
Date: Mon, 29 May 2006 20:34:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605292031100.11164@tm8103-a.perex-int.cz>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291540430.11164@tm8103-a.perex-int.cz>
	<Pine.LNX.4.61.0605291601230.11164@tm8103-a.perex-int.cz>
	<s5hbqtg9a8a.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291630000.11164@tm8103-a.perex-int.cz>
	<447B0F62.6010802@superbug.co.uk> <s5hzmh0deir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 617BF159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 20:34:56 +0200 (MEST)
In-Reply-To: <s5hzmh0deir.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 29 May 2006, Takashi Iwai wrote:

> At Mon, 29 May 2006 16:12:34 +0100,
> James Courtier-Dutton wrote:
> > 
> > Jaroslav Kysela wrote:
> > > On Mon, 29 May 2006, Takashi Iwai wrote:
> > > 
> > >> What we'll get by this compression is only the reduction of ioctl
> > >> size.  But, these ioctls are called not so often and no time-critical
> > >> task.
> > > 
> > > Nope. I'm talking about saving code in alsa-lib. Having a special case in 
> > > alsa-lib for all hints is not really good. If you can store all necessary 
> > > ranges to 32-bit value (which is allocated anyway) is a win. Of course, 
> > > all mechanisms as James proposed will not be changed. I see only one 
> > > problem why my proposal is not acceptable - we must store also the 
> > > identifier type to the 32-bit value in the kernel side. Also, having both 
> > > min and max values is not necessary (it can be evaluated from step).
> > > 
> > I don't understand where you think you are making a win with these
> > 32-bit values? None of the information is stored in alsa-lib after the
> > function has returned to the user app. It is all temporary use.
> 
> Maybe cached values to avoid too frequent ioctls?
> 
> But, still it won't save so much memory at all, given that we have at
> most 100 controls with volumes...

Sorry, I was looking to the proposed patch very quickly so my ideas were
based on old implementation which is #if 0 #endifed for alsa-lib (there 
was only one 32-bit hint value specifying the dB expression).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
