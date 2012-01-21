From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to
 set the msbits constraint"
Date: Sat, 21 Jan 2012 16:05:06 +0200
Message-ID: <4F1AC612.3090808@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
	<1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
	<20120119182602.GM3178@opensource.wolfsonmicro.com>
	<4F1861E6.1000700@ti.com>
	<20120119190701.GN3178@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 14A7D24576
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 15:05:12 +0100 (CET)
Received: by eeit10 with SMTP id t10so285581eei.15
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 06:05:09 -0800 (PST)
In-Reply-To: <20120119190701.GN3178@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Sorry for the delay, I'm traveling.

On 01/19/2012 09:07 PM, Mark Brown wrote:
> Please take a step back (I know I'm rather annoyed and am trying to do
> so myself), none of this is getting us anywhere.

Agreed. This was not entertaining for me at least. I'm sure we just
overlook each other's point of view.
I had some time to think this over with a 'clean' head.
AFAIK we only place this constraint to 32bit samples. I have not
encountered any other HW limitation.
What if we just simply convert the msbit core support to apply the
constraint to 32 bit samples only?
With the current code we are not able to apply different constraint to
different sample size anyway.
Locally I have added the support for this, but it looks like over
engineering.
I have the patch(s) for both way, but I think we are better off if we
support 32 samples only (simple, clean, covers 99% of use case, well as
it is now it covers 100%).

> We've got real CPU consumption problems in ASoC - the DAPM algorithm is
> the biggest one, even with the work I did recently to mitigate against
> it it's still got the ability to explode dramatically to the point where
> it's user visible as the worst case is well over O(n^2).  There's plenty
> of low hanging fruit that it'd be much better to spend time on here - as
> a quick example every time we start or stop a stream we do a linear
> search of all DAPM widgets looking for those that might be affected
> based on a string match in order to kick DAPM for them.  That's O(n) in
> the number of widgets in the card plus the strcmp() costs.

And things aren't getting any simpler. For sure we need to do something
about this.

> We'll all get *much* more benefit from working on improvements of things
> like that (and on the memory consumption which isn't great either and
> probably manages to burn measurable CPU cycles due to cache misses) than
> we ever will from anything we do with this code.

You know Mark, I'm an engineer. It bothers me. It bothers me more since
I _know_ it is there. I just can not help myself...
Sorry about that.

-- =

P=E9ter
