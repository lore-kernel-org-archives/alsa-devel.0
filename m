From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 20:38:23 +0200
Message-ID: <20100614183823.GB14916@tango.0pointer.de>
References: <AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTikknwiaVOWUwtWsiNOc0j3VtG3YMEMkRO1o2w2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F78D2474A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 20:38:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikknwiaVOWUwtWsiNOc0j3VtG3YMEMkRO1o2w2f@mail.gmail.com>
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

On Mon, 14.06.10 16:45, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> The correct way is to provide the real ALSA 's 0dB point (Playback volume)
> for the user of AC97 sound card so that they can record without any
> distortion using line in with the loopback cable connected to line out.

Jeez, man, I explained that in my original reply.

If I may quote myself:

   'On top of that most volume controls should then mark the ALSA 0dB
   point as "base" volume on the slider, at what PA then calls -y dB.

   That way we will expose 0dB as maximum hw amplitude uniformly on all
   sound cards and have a special point on the slider that is hinted to be
   the "comfort" point.

   This is all explained on
   http://pulseaudio.org/wiki/WritingVolumeControlUIs#BaseVolumes'

See? It's all explained there. We still show the ALSA 0dB point on our
sliders, we just don't call it "0dB" but "base volume".

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
