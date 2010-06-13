From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: wrong decibel data?
Date: Sun, 13 Jun 2010 15:53:49 +0200
Message-ID: <20100613135349.GB5818@tango.0pointer.de>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A9238244B9
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 15:54:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <hur2pt$uaa$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 10.06.10 17:11, Colin Guthrie (gmane@colin.guthr.ie) wrote:

> 
> 'Twas brillig, and Raymond Yau at 10/06/10 04:16 did gyre and gimble:
> > Can you explain how PA handle the volume controls of ac97 codec ?
> > 
> > PCM -34.5dB to +*12* dB
> > Master -46.5dB to 0dB
> > 
> > The total dB range (PCM + MASTER) is -81dB to +*12*dB
> > 
> > 
> > Most user concern about recording without distrotion. (i.e. best result when
> > Capture Volume at 0dB , PCM and Master Volume at 0dB ) and they need where
> > are 0dB points
> 
> I'm not 100% sure how this is handled, but I know it's not ignored.
> You'll have to ask Lennart directly or dig in the code to see for sure.

If the ALSA volume range is -x dB to +y dB, then the PA volume range
will be -x-y dB to 0dB (i.e. shifted by -y dB). On top of that most
volume controls should then mark the ALSA 0dB point as "base" volume on
the slider, at what PA then calls -y dB.

That way we will expose 0dB as maximum hw amplitude uniformly on all
sound cards and have a special point on the slider that is hinted to be
the "comfort" point.

This is all explained on
http://pulseaudio.org/wiki/WritingVolumeControlUIs#BaseVolumes

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
