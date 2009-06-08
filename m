From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 8 Jun 2009 22:26:44 +0400
Message-ID: <20090608222644.2e83519f.baz@irc.msk.ru>
References: <4A2ABD52.8000600@googlemail.com>
	<s5h4ourqkkk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [217.112.17.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DE1024548
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 20:26:46 +0200 (CEST)
In-Reply-To: <s5h4ourqkkk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Jun 2009 08:57:31 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 06 Jun 2009 21:02:42 +0200,
> Gernot Kohlhaas wrote:
> > 
> > Hi and thanks for this driver.
> > It works great and even 6- and 8-Channel-Output is supported now.
> > 
> > The only two little things I noticed are:
> > 1. Most programs are looking for "surround51" to use for
> > multichannel sound. But this driver only provides the
> > "default"-Device (in it's description it says:
> > 
> > aplay -L
> > default:CARD=XFi
> >     Creative X-Fi, Front/WaveIn
> >     Default Audio Device
> > 
> > )
> 
> Use the latest alsa-lib snapshot.  The config file for X-Fi is already
> there.
Hmm... I see a definition for iec958 in SB-XFI.conf, but aplay -L
doesn't list it for my card.

root@mayonaka:~# aplay -L
default:CARD=XFi
    Creative X-Fi, Front/WaveIn
    Default Audio Device
front:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    Front speakers
surround40:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    4.0 Surround output to Front and Rear speakers
surround41:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=XFi,DEV=0
    Creative X-Fi, Front/WaveIn
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)


-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
