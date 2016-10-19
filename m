From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v2 3/3] dt/bindings: Add milivolt, milliamps,
 and nanohenry units
Date: Wed, 19 Oct 2016 08:15:49 -0500
Message-ID: <1e00c694-4001-4beb-8564-a40fbafca297@EX4.ad.cirrus.com>
References: <CAL_JsqKdV7133oo5jECZn2SwVjMM3E_ZNr+JS=9Wtkx8BZVuEQ@mail.gmail.com>
 <6ca3d940-4822-42d5-8606-cfc4c815c7ad@EX4.ad.cirrus.com>
 <20161018132847.hwaij5j5ohyvwoed@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1605296000-1476882949=:3197"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 323592667EA
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 15:15:51 +0200 (CEST)
In-Reply-To: <20161018132847.hwaij5j5ohyvwoed@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--8323329-1605296000-1476882949=:3197
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT

On Tue, 18 Oct 2016, Rob Herring wrote:

> On Tue, Oct 18, 2016 at 12:43:48AM +0000, Handrigan, Paul wrote:
> > 
> > 
> > 
> > >>  Electricity
> > >>  ----------------------------------------
> > >>  -microamp      : micro amps
> > >> +-milliamp      : milli amps
> > >
> > >Please explain why you need need this. Is 2^32 uA not enough range for
> > >you? While we do have multiple units for some, that's because people
> > >picked arbitrary units for their properties before this doc existed.
> > >Ideally, we only have 1 unit to prevent that problem.
> > 
> > 2^32 would be enough, however, microamps would not be a good
> > representation for
> > this particular entry. For example, if the current limit is 2.1A the
> > entry will have to be 2100000.  Micro amps will not be the best
> > representation for this value from a scientific notation perspective.
> > Since the scale is in miiliamps as it is defined in the data sheet of
> > this device, it will be best to stay consistent since an error in
> > conversion
> > could cause serious problems.
> > 
> > Also, I really don¹t see why adding milliamps and millivolts as being a
> > major
> > problems since both of them are commonly used.
> 
> As I explained, we want to have some uniformity in properties especially 
> across different bindings. That's not something I want to check in every
> review. Telling people to add units is enough.
> 
> I don't see how adding '000' is a problem.
> 
> Rob
> 
Why is it such a big deal to not have a representation for all the common 
units of measurement? They are already defined so why not add them to your 
suffix file? I would think that if you are going to make us use this 
suffix devicetree thing, you would not restrict us to use only the units 
you think are appropriate.

I wouldn't think you would restrict us to saying it is a 5700ml Hemi V8 
would you?


Brian
--8323329-1605296000-1476882949=:3197
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1605296000-1476882949=:3197--
