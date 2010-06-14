From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 20:46:12 +0200
Message-ID: <20100614184612.GD14916@tango.0pointer.de>
References: <huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<AANLkTinilBSWTBkBjoGK5CgDm-9cXJvMLwB-952FINle@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 96A0B2474D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 20:46:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinilBSWTBkBjoGK5CgDm-9cXJvMLwB-952FINle@mail.gmail.com>
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

On Mon, 14.06.10 17:54, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> The base volume seem to be the software 0dB point , (no software
> gain/atten), but the user want the hardware 0dB point (no hardware
> gain/atten if the hardware can provide hardware gain

jeez man, this is nonsense.

In PA we call the max hw amplification 0dB. And then we extend things
both ways in software. And finally we mark the ALSA 0dB spot (i.e. the
*hardware* 0dB spot) as "base volume".

There is nothing lost here.

And you get a cookie if you read this:

http://pulseaudio.org/wiki/WritingVolumeControlUIs#BaseVolumes

and this:

http://pulseaudio.org/wiki/WritingVolumeControlUIs#Colouredvolumesliders

And then you'll notice that we actually thought about hw and sw volume
ranges quite a bit and nothing is lost. For example, our recommended
color-coded UI will mark the ALSA 0dB spot with a color transition from
green to yellow, to give the user an idea that things get worse beyond
that point, even if he doesn't understand dB or hw or sw volumes.

Please, just drop this thread now, and just read the wiki. Thanks.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
