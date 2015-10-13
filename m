From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Wed, 14 Oct 2015 00:20:51 +0200
Message-ID: <20151014002051.4fa8b0fa@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp>
 <20151013100228.GA16452@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EB56264FE7
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 00:20:53 +0200 (CEST)
In-Reply-To: <20151013100228.GA16452@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Oct 13 Jonathan Woithe wrote:
> for cases like MOTU, where mixer control setting updates
> are pushed to the computer by the device in response to front panel actions,
> there will be a need for userspace to somehow tap into this flow.  Userspace
> could not gain access to the iso stream because the kernel will have control
> over that.  Or can userspace tap into iso streams that have been initiated
> by the kernel (that is surprising to me if it's true).

Indeed we do not have support for multiple local listeners on the same
stream.  (firewire-core supports multiple listeners for FCP reception, but
this is a simpler case in several respects.)

I guess getting MOTU status out to userspace could work by having the
audio driver extract the data from the stream and push it as a new type of
event of the <sound/firewire.h> API through the ALSA hwdep interface.

(Apologies for going somewhat offtopic.)
-- 
Stefan Richter
-=====-===== =-=- -==-=
http://arcgraph.de/sr/
