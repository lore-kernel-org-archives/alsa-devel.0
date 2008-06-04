From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: alsa-drivers-HEAD does not compile
	against	recent	RHE5.1 kernels
Date: Thu, 05 Jun 2008 01:38:02 +1000
Message-ID: <1212593882.28032.123.camel@localhost>
References: <1211506900.3811.105.camel@localhost>
	<1211542742.3811.139.camel@localhost>
	<1211545221.3811.142.camel@localhost>
	<1212104263.17410.114.camel@localhost> <s5habi15rck.wl%tiwai@suse.de>
	<1212592348.28032.111.camel@localhost> <s5hskvt44eb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F06F2444F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 17:38:06 +0200 (CEST)
In-Reply-To: <s5hskvt44eb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 2008-06-04 at 17:16 +0200, Takashi Iwai wrote:
> At Thu, 05 Jun 2008 01:12:28 +1000,
> Ben Stanley wrote:
> > 
> > So, if config.h is not needed in 'newer' kernels (and causes an error?),
> > and is needed in 'older' kernels, it is then an error to universally
> > include it in a configure test program where it causes an error if used
> > inappropriately...
> 
> Well, apparently it's only RH kernels that cause the problem.
> So I haven't cared about it at all.
> 
> > I think the error is not noticed in newer newer kernels because
> > init_utsname is defined in newer newer kernels. (I should look into this
> > statement some more.)
> 
> The problem is, as usual, RH kernels backported init_utsname in a
> different way than the upstream.  This makes things really hard.
> 
> 
> Takashi

Since its a RH kernel problem, I was hoping to prod a response out of
Jaroslav :-) .

This was a real PITA for us because the sound card manufacturer's
supported build procedure required updating the system ALSA to a
particular version before building their driver. The broken test for the
init_utsname symbol prevented this.

Anyway, in the end I have worked around this issue because I have
successfully compiled the driver in question against the kernel headers
as an external module without the need to use ALSA as a base. This also
makes the configuration more supportable from my point of view, as I
don't have to worry about re-testing everything else that depended on
the original system version of alsa. And getting the driver to compile
against RH kernel 2.6.18-53.1.19 was only really a matter of backporting
it to alsa 1.0.14 , which turned out to be not too hard. This build
procedure also allows me to use dkms to manage the installation of my
driver, which is something of a bonus.

Ben Stanley.
