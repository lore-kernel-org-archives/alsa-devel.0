From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [snd-bt87x]: seems cannot powerup after
	powerdown...
Date: Tue, 19 Aug 2008 10:04:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0808191002300.23833@shell4.speakeasy.net>
References: <48A993AC.2010900@odu.neva.ru> <s5hzln9wa0t.wl%tiwai@suse.de>
	<48AAB4C8.70803@odu.neva.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.sea5.speakeasy.net (mail1.sea5.speakeasy.net
	[69.17.117.3]) by alsa0.perex.cz (Postfix) with ESMTP id B2FCD2447E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Aug 2008 19:04:25 +0200 (CEST)
In-Reply-To: <48AAB4C8.70803@odu.neva.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Butskoy <buc@odusz.so-cdu.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Aug 2008, Dmitry Butskoy wrote:
> Takashi Iwai wrote:
> > Added Clemens and alsa-devel to Cc.
> >
> > At Mon, 18 Aug 2008 19:22:20 +0400,
> > Dmitry Butskoy wrote:
> >
> >> Hi,
> >>
> >> Recently snd-bt87x driver has started to use CTL_A_PWRDN bit, see
> >> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.26.y.git;a=commitdiff;h=950fb626dc28e17ae4ad01dba07957bdc6e0b997
> >>
> >> Unfortunately, it produces a regression, at least in my case.
> >>
> >> I have "AVerMedia TVPhone 98" card, lspci is:

Which PCM device are you using?
