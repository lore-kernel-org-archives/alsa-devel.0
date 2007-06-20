From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: at91 SoC Modifications
Date: Wed, 20 Jun 2007 16:46:11 -0500
Message-ID: <61c0054e0706201446o251b3cb9ja232be776a31162b@mail.gmail.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id AF6D8243D2
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 23:46:12 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so440070uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 14:46:12 -0700 (PDT)
In-Reply-To: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Okay:

Working on my new format. Backed up at91-ssc.c and now writing a supplement
to it including my new format, which I will dub SND_SOC_DAIFMT_PCM_L unless
someone has an objection to that.

I need to define it in sound/soc.h I notice the other defs as:

#define SND_SOC_DAIFMT_I2S        0    /* I2S mode */
#define SND_SOC_DAIFMT_RIGHT_J    1    /* Right justified mode */
#define SND_SOC_DAIFMT_LEFT_J    2    /* Left Justified mode */
#define SND_SOC_DAIFMT_DSP_A    3    /* L data msb after FRM or LRC */
#define SND_SOC_DAIFMT_DSP_B    4    /* L data msb during FRM or LRC */
#define SND_SOC_DAIFMT_AC97        5    /* AC97 */

so, could I add a line:

#define SND_SOC_DAIFMT_PCM_L    6    /* PCM Long Sync Format*/

..without too many hassles? Just want to make sure i am not violating a
standard or something.

Thanks.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
