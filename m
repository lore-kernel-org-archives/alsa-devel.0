From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 20 Oct 2015 10:15:38 +1030
Message-ID: <20151019234538.GC8953@marvin.atrad.com.au>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp>
 <20151013100228.GA16452@marvin.atrad.com.au>
 <5624FC55.8000100@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id AE0BB2652C5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:45:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5624FC55.8000100@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

On Mon, Oct 19, 2015 at 11:21:09PM +0900, Takashi Sakamoto wrote:
> > Now that there is functional infrastructure within ALSA to build on I am
> > hoping to start experimenting with RME and MOTU devices over the next few
> > months by porting my FFADO streaming drivers to ALSA.
> 
> This year I got some supports (not commercial) from Japan office of
> Synthax Inc. They lent some RME models to me. At the beginning of audio
> and music unit on IEEE 1394 bus, I'll borrow FireFace 400 and start to
> develop for ALSA RME driver, next month.
> 
> Currently, ALSA MOTU driver is under working in my repository, so it's
> better to start your development for it.

To be honest I would rather see the RME functionality in place first because
MOTU are hostile to Linux and have never provided any assistance to Linux
development efforts.  While I definitely want to migrate the MOTU FFADO
streaming driver into the kernel, RME is definitely my priority at this time
and what I want to spend my very limited development time on.

You obviously have far more time to work on this than me at the present
moment so I suspect you'd get something working before me.  That's fine. 
However, when you are ready to start working on the RME driver I would very
much like to talk to you about the infrastructure required in order to make
it possible to add support for the rest of the family beyond the FF400 along
with other features which may not be immediately obvious by a reading of the
FFADO driver code.  I have ideas about how this might come together.

Regards
  jonathan
