From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ASoC: davinci-mcasp: Improved
	suspend/resume support
Date: Thu, 2 Oct 2014 10:21:31 +0300
Message-ID: <542CFCFB.4060709@ti.com>
References: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
 <20141001160240.GC4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 5050526051E
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 09:21:36 +0200 (CEST)
In-Reply-To: <20141001160240.GC4273@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/01/2014 07:02 PM, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 04:02:10PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> With this series the McASP will continue to work after deep sleep during=
 audio
>> activity.
>> Without these changes the ongoing audio will not resume and it will time=
 out,
>> but streams started after resume were worked correctly.
> =

> Applied both, thanks.  Might be worth converting to regmap and using the
> cache code?

Yes, it is in my to-do list. One thing I'm a bit puzzled currently is on how
to handle the serializer registers. Depending on the SoC the McASP is
integrated in we can have different number of serializers, also in some SoC
different McASP ports have different number of serializers. I do not want to
have separate regmap struct for all of these (which would most probably mea=
ns
different compatible flag in DT). I also want to avoid wiring in some max
limit of the serializer registers. But probably I need to do this at the en=
d.

-- =

P=E9ter
