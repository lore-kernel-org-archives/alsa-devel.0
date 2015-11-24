From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: M-audio 410 : complex procedure to get a sound
Date: Tue, 24 Nov 2015 23:20:02 +0900
Message-ID: <56547212.3010507@sakamocchi.jp>
References: <564999E5.30204@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF0E265A70
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 15:20:06 +0100 (CET)
In-Reply-To: <564999E5.30204@yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ROUGE ETIENNE <etiennerouge@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 16 2015 17:55, ROUGE ETIENNE wrote:
> I've just bought a M-audio firewire 410 and I'm very thankfull to
> takashi's work that allows us to use the device almost like an USB one !
> 
> I can have sound and have access to the routing controls. However 2 bugs
> makes it a bit tedious :
> 
> NOTE : I use an up to date freshly installed ubuntustudio 15.10. The
> only modifications I made was 1) deleting pulse 2) select the soundcard
> as default in asoundrc
> 
> 1) I do not have sound out of the box, but I can manage to have sound by
> starting ffado-mixer then force restart alsa. After that everything
> works fine.... but I gotta do it at every restart which isn't nice

ALSA BeBoB driver doesn't touch internal multiplexer of your device.
Thus, you need to use the other tools such as ffado-dbus-server/ffado-mixer.

This comes from a design that functionalities except for packet
streaming should be implemented in userspace applications. This results
to diet codes for kernel streaming driver.

Additionally, each model which ALSA BeBoB driver can support has each
design, model-dependent functionalities. This may bring much codes if
implemented in kernel space, and make it hard to maintein.

> 2) ffado-mixer suffers several bugs :
> - if I close the window I can't restart it again unless I kill
> ffado-dbus-server (it says : "another instance of ffado-mixer is already
> running).
> -  I got few errors on startup "invalid samplerate for input"... don't
> know it it has any impact
> - when I tweak too much ffado-mixer (AFAIK, it's random, but happens
> within few minuts) the mouse shows a 'hand closed' cursor and I can't
> click anything. The system remains fully functionnal, but I can't close
> anything nor click... If I start an emergency terminal I can kill
> whatever I want, but the problem remains.
> 
> I'll try with a fedora this evening to see if it's not related with
> ubuntustudio, but I'd be glad to have some help with those 2 issues
> (especially the stalling ffado-mixer)

Hm, I'll check ffado tools to clear these two issues. But I'll recommend
you to post them to ffado-devel because the tools are not related to
ALSA project.


Thanks and sorry to be late for catching up.

Takashi Sakamoto
