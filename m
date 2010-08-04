From: Timur Tabi <timur@freescale.com>
Subject: Re: arecord: main:552: audio open error: Invalid
	argument
Date: Wed, 4 Aug 2010 16:15:36 -0500
Message-ID: <AANLkTi=JLB7uqkMjoy7m3yy-aWTeT1opU3QUMXL2VEt8@mail.gmail.com>
References: <4C59C5C1.50504@freescale.com>
	<20100804200117.GB5864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3DC00246CE
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 23:16:07 +0200 (CEST)
Received: by vws20 with SMTP id 20so4979725vws.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 14:16:06 -0700 (PDT)
In-Reply-To: <20100804200117.GB5864@sirena.org.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 4, 2010 at 3:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> The symmetric_rates infrastructure was only ever really intended to work
> over a single DAI so I'd not be at all surprised if it gets a little
> confused (though I'm surprised it's doing anything at all).

Makes sense.  Should I forget the symmetric_rates feature and just
handle it internally in my driver?

-- 
Timur Tabi
Linux kernel developer at Freescale
