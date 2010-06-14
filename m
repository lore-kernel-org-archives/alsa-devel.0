From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 16:27:32 +0100
Message-ID: <AANLkTinJgLgznquX5nITzHDuAe-5e_lhk5owBhCN7wqO@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>
	<hv5dkf$tv8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id AF886246C4
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 17:27:34 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 19so891628fgg.2
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 08:27:33 -0700 (PDT)
In-Reply-To: <hv5dkf$tv8$1@dough.gmane.org>
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

On 14 June 2010 15:17, Colin Guthrie <gmane@colin.guthr.ie> wrote:
>
> I've made this change on my system and while previously my UI had no
> "Base Volume" displayed (because all my "h/w" (I include softvol in
> that) controls had their dB value >0.
>
> Now that this change is live, I have a base volume present in my GUI (at
> around the 64% mark with the cubic scale we've already discussed). When
> I set my volume ot the base volume, the h/w controls are all set to 0dB
> which is exactly as expected.
>
> I fail to see the point here? The base volume is clearly exposed to the
> as the recommended point on the scale at which no clipping occurs.
>
> I really don't get where your complaint is.
>

Well, if you can define "Volume" in a way that lets you understand
this then fine.
For me, all these controls are not adjusting "Volume", they are
adjusting "Gain", so why are they even called "Base Volume".
