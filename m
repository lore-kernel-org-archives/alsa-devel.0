From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: snd_ prefix for module options
Date: Tue, 8 Oct 2002 23:44:46 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021008224446.26961.qmail@web40611.mail.yahoo.com>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzvh2fid.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote: > Hi,
> so, i'd like to ask you how do you think to remove
> this snd_ prefix.
> of course, there is one and only big problem -
> compatibility!

I think it's a worthy goal. It's just noise in
modules.conf, of course. Irritating, but no more than
that. What concerns me more is when you compile ALSA
directly into the kernel. To pass the options NOW
requires a boot-time parameter list:

alsa-module-name=snd_this=x,snd_that=y,snd_the_other=z

Every "snd_" here wastes 4 precious bytes on the
kernel's command line. Now I don't know what the
maximum length of the command line is, but I'm sure
I've reached it before. (And had the trailing options
silently ignored.) I think economy is only polite with
such a limited resource.

As for "when", I'd say that the longer you wait, the
greater the pain. I have a fairly complicated setup,
and the extent of my pain would be here:

options snd snd_cards_limit=2
options snd-card-0 snd_index=0
options snd-card-1 snd_index=1 snd_mpu_port=0x330

(Aren't PCI devices nice :-)?) I guess the worst hit
would be people with ISA sound cards.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
