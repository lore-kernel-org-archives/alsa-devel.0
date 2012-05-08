From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Remove HS/HF gain ramp
	feature
Date: Tue, 08 May 2012 14:46:54 +0300
Message-ID: <4FA907AE.4060409@ti.com>
References: <1336133840-12330-1-git-send-email-peter.ujfalusi@ti.com>
	<20120507172732.GP17002@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CB2C2436E
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:46:41 +0200 (CEST)
Received: by lbol5 with SMTP id l5so3968230lbo.6
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:46:38 -0700 (PDT)
In-Reply-To: <20120507172732.GP17002@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 05/07/2012 08:27 PM, Mark Brown wrote:
> On Fri, May 04, 2012 at 03:17:20PM +0300, Peter Ujfalusi wrote:
>> None of the machines uses the gain ramp possibility for HS/HF.
>> This code path is mostly unused and it does not reduces the pop
>> noise on the output (it alters it to sound a bit different).
>> The preferred method to reduce pop noise is to use ABE.
> =

> ...to implement gain changes?

To fix up the pop noise.

After this feature was implemented to reduce the pop noise it become
clear that the underlying issue can be better solved with the offset
cancellation feature within ABE.
It turned out that the ramp code (which was implemented and deployed at
the same time as the ABE offset cancellation) alone just alters the
quality of the pop. With the ABE solution alone we are fine.

> Applied, thanks.

Thank you,
P=E9ter
