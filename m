From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: ASOC v2 driver structure
Date: Mon, 28 Jan 2008 13:06:10 +0000
Message-ID: <1201525570.3551.47.camel@localhost.localdomain>
References: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
	<9e4733910801271115w576fcd61pec8a5586138744c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id 47D742439A
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 14:06:11 +0100 (CET)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T84ccea0071ac1408057dc@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 13:06:10 +0000
In-Reply-To: <9e4733910801271115w576fcd61pec8a5586138744c5@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2008-01-27 at 14:15 -0500, Jon Smirl wrote:
> On 1/27/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I'm trying to write an asoc v2 driver for my powerpc based SOC
> > (mpc5200) hardware. We have two audio devices on the board, a WM8580
> > and a TAS5504.  How do you do this with asoc v2? The card is created
> > in snd_soc_machine_create(); there seems to be an assumption of a
> > single card per machine.

This was the initial assumption in v1. To be honest we were only
catering for single codec devices. In v2 we are allowing multiple cards
- struct machine is being refactored atm to make this more obvious.

> >
> > Or are you supposed to mix the different devices into a single pcm
> > driver? What would happen in pxa2xx-pcm.c if more than one of these
> > were defined?
> 
> I guess I'm supposed to have multiple platform drivers - one per
> I2C/AC97/SSC channel?
> 

You could do this or create two cards (machines). I've kept platform as
the DMA + all the interfaces (as some devices have more than one
interface in operation e.g. AC97 for HiFi and I2S/PCM for voice).

Liam


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK
