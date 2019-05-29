From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/6] device property: Add new array helper
Date: Wed, 29 May 2019 10:48:14 +0100
Message-ID: <20190529094814.GH28362@ediswmail.ad.cirrus.com>
References: <20190528154312.14435-1-ckeepax@opensource.cirrus.com>
 <CAJZ5v0h28OAiT7KP=TLu069hNvYjCLoFndS+zx7_iE+jKfOF2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4000FF8065A
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 11:48:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h28OAiT7KP=TLu069hNvYjCLoFndS+zx7_iE+jKfOF2w@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 07:01:38PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 28, 2019 at 5:43 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > It is fairly common to want to read an integer array property
> > that is composed of an unknown number of fixed size integer
> > groups. For example, say each group consists of three values
> > which correspond to the settings for one input on the device
> > and the driver supports several chips with different numbers
> > of inputs.
> >
> > Add a new helper function to provide this functionality, it
> > differs for the existing helpers in that it allows reading a
> > smaller number of values than the full array size and checks
> > that the number of values read is a multiple of the group size.
> 
> As a rule, you need also CC all of the device property framework
> changes to linux-acpi@vger.kernel.org, so please resend the series
> with that taken into account.
> 

Sorry will resend with them included.

Thanks,
Charles
