From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] AC97 bus interface for ad-hoc drivers
Date: Thu, 28 Jul 2005 21:26:39 +0100
Message-ID: <1122582399.5371.90.camel@localhost.localdomain>
References: <1121775624.14604.14.camel@cearnarfon>
	 <s5hbr4old2a.wl%tiwai@suse.de>
	 <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-07-27 at 09:05 -0400, Nicolas Pitre wrote:
> On Wed, 27 Jul 2005, Takashi Iwai wrote:
> > 
> > Better to keep snd- prefix for ac97_bus module (although it can be
> > used independently from ALSA)...?  It's an open question.
> 
> The idea is to be able to use ALSA as modules and the extra function 
> driver linked in, or vice versa.  Therefore ac97_bus.o should probably 
> be selected with its own config symbol allowing for things like:
> 
> config UCB1400_TS
> 	tristate "UCB1400 touchscreen interface"
> 	select AC97_BUS
> 
> 
> And similarly:
> 
> config SND_AC97_CODEC
> 	...
> 	select AC97_BUS
> 
> This way there is no hard linkage depedency between ALSA and any ad-hoc 
> codec function driver.

I've just unsuccessfully tried to create this dependency in the Kconfig
system. It looks like you cannot do:-

config SND_SOME_DRIVER
	tristate "some driver"
	select SND_AC97_CODEC

config SND_AC97_CODEC
	tristate 
	select SND_PCM
	select SND_AC97_BUS

config SND_AC97_BUS
	tristate

In this scenario SND_SOME_DRIVER selects SND_AC97_CODEC selects
SND_AC97_BUS and I could never get a SND_AC97_BUS=m or otherwise in
my .config. I was only ever successful by adding the select SND_AC97_BUS
line to SND_SOME_DRIVER.

I now don't think that the "select SND_PCM" is having any effect in the
AC97_CODEC config, although it still builds fine when remove it.

With this in mind (I'm not sure if this is intentional in the build
system or not), it might be better to stick with the original Makefile
and rename the module with a snd- prefix.

Liam

 

  



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
