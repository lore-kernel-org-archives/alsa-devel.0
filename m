From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Re: WM9712 Not Giving output
Date: Sat, 2 Aug 2008 02:46:17 -0700 (PDT)
Message-ID: <619046.61482.qm@web50105.mail.re2.yahoo.com>
References: <20080801183711.GG11735@sirena.org.uk>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50105.mail.re2.yahoo.com (web50105.mail.re2.yahoo.com
	[206.190.38.33]) by alsa0.perex.cz (Postfix) with SMTP id BF65324635
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 11:46:18 +0200 (CEST)
In-Reply-To: <20080801183711.GG11735@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-- On Sat, 2/8/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] WM9712 Not Giving output
> To: "Nitin Mahajan" <nitinm76@yahoo.com>
> Cc: "Marek Vasut" <marek.vasut@gmail.com>, alsa-devel@alsa-project.org
> Date: Saturday, 2 August, 2008, 12:07 AM
> On Fri, Aug 01, 2008 at 11:26:36AM -0700, Nitin Mahajan
> wrote:
> 
> > > yea, and you should see alsa warning about it in
> kernel log
> > > as well.
> 
> > Do you mean in dmesg?
> > Unfortunately I don't have hardware with me now to
> test. I shall do it tommorow morning.
> 
> Yes, but you won't see that log message with the older
> kernel you are
> using unless you have also backported ASoC from the current
> kernel (but
> if you've done that I'd have expected you'd
> have backported a current
> version with the patch in question already applied).

I checked the mixer configuration.The registers 0x18h and 0x04h were mute at the time of initiating DMA for playback.

I did set both registers with 0x7fff. From mixer point of view, If I am using an headphone, are these registers enough? I am still not able to hear anything.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Send instant messages to your online friends http://uk.messenger.yahoo.com 
