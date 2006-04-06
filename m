From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Cross compiling alsa-driver
Date: Thu, 06 Apr 2006 19:55:08 -0400
Message-ID: <1144367709.12038.48.camel@mindpipe>
References: <1144187819.9472.25.camel@localhost.localdomain>
	 <s5hwte4ntxt.wl%tiwai@suse.de>
	 <1144361810.9219.6.camel@localhost.localdomain>
	 <1144362329.12038.22.camel@mindpipe>
	 <1144362544.9219.14.camel@localhost.localdomain>
	 <1144364276.12038.31.camel@mindpipe>
	 <1144365041.9219.18.camel@localhost.localdomain>
	 <1144365316.12038.37.camel@mindpipe>
	 <1144365957.9219.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144365957.9219.20.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-04-07 at 00:25 +0100, Adrian McMenamin wrote:
> And your point is?
> 
> I've written those files. cvscompile bombs 

It looks like you just need to add something like:

ifeq (y,$(CONFIG_SH))
SUBDIRS  += sh
endif

to alsa-driver/Makefile, then create alsa-driver/sh/Makefile like:

ifndef SND_TOPDIR
SND_TOPDIR=..
endif

include $(SND_TOPDIR)/toplevel.config
include $(SND_TOPDIR)/Makefile.conf

include $(SND_TOPDIR)/alsa-kernel/sh/Makefile

include $(SND_TOPDIR)/Rules.make

Then create alsa-kernel/sh/Makefile:

#
# Makefile for ALSA
#

snd-aica-objs := aica.o

# Toplevel Module Dependency
obj-$(CONFIG_SND_AICA) += snd-aica.o

and put your code and Kconfig file in alsa-kernel/sh/






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
