From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Linux 2.6.21 regression with hda-intel
	(Conexant	5045)
Date: Thu, 17 May 2007 08:02:12 -0700
Message-ID: <1179414132.4415.295.camel@razman.gruemaster.com>
References: <f2h9a9$d15$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F6662447B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 17:02:14 +0200 (CEST)
In-Reply-To: <f2h9a9$d15$1@sea.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: G.Ohrner@post.rwth-aachen.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patch 22 was specific to a few HP laptops with the CX20551 codec (you
have the CX20549).  The driver has been undergoing quite a bit of
refinement over the last few months, so I'm not sure which version is in
what kernels.  The best thing to do is download the
alsa-driver-1.0.14rc4.tar.bz2 release from alsa-project.org and use it.
It is the most current for that codec.

Tobin


On Thu, 2007-05-17 at 12:04 +0200, Gunter Ohrner wrote:

> Hi!
> 
> First of all: Sorry if this question is dumb or a fix should be obvious, but
> as a non-ALSA_expert I'm a bit a a loss at the moment... I searched the
> bugtracker and this list but could not find anything appropriate - most
> probably I missed a relevant post or didn't recognize it as being
> relevant...
> 
> Any pointers are greatly appreciated!
> 
> The situation is as follows: Using Linux 2.6.20.4, my laptop's soundcard
> works just fine. Using 2.6.21.1, it also works, but the headphone socket is
> dead. Plugging a headphone into it correctly mustes the internal speakers,
> but no sound is output via the headphones.
> 
> Details:
> 
> - Fujitsu Simens Amilo Si1520
> - Codec: Conexant ID 5045 (as reported by Linux 2.6.20.4)
> 
> Alsa device details between both Linux kernels differ completely, with Linux
> 2.6.20.4 only reporting a single a single analog PCM device and Linux
> 2.6.21.1 reporting a Conexant Analog and a Conexant Digital device. Should
> I still post the complete information from /proc/asound/* for both kernels?
> 
> I tried applying conexant-test22.patch by Tobin Davis, but it does not seem
> to match the in-kernel ALSA code. It also does not seem to be related to
> the 5045 chip...
> 
> Any ideas?
> 
> Greetings,
> 
>   Gunter
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
