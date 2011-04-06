From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8903 line output mute/volume,
	and POWER_MANAGEMENT_3
Date: Thu, 7 Apr 2011 08:02:02 +0900
Message-ID: <20110406230201.GC5297@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB374D@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F107103859
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 01:01:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB374D@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Jordan Nien <JNien@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dilan Lee <dilee@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, 2011 at 01:28:15PM -0700, Stephen Warren wrote:

> Below is a patch from a colleague that fixes this. Is it correct? I see
> precedent for this sequencing setup in the Speaker PGA setup. However, the
> datasheet implies (by considering together in the same section) that the Line
> and Headphone Output PGAs are typically programmed in the same fashion, and
> they already were in the code. Perhaps the Headphone Output PGA also has an
> issue and needs similar rework?

They both need a similar change, yes.  This is due to an error in an
earlier revision of the datasheet which incorrectly listed the PGA
enables in the power management registers as being copies of the ouput
first stage enables.
