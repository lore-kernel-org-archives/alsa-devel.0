From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: at91 SoC Modifications
Date: Thu, 21 Jun 2007 13:07:52 +0100
Message-ID: <1182427672.26658.186.camel@localhost.localdomain>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706201446o251b3cb9ja232be776a31162b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 058D310383A
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 14:07:58 +0200 (CEST)
In-Reply-To: <61c0054e0706201446o251b3cb9ja232be776a31162b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-06-20 at 16:46 -0500, Paul Kavan wrote:
> Okay:
> 
> Working on my new format. Backed up at91-ssc.c and now writing a
> supplement to it including my new format, which I will dub
> SND_SOC_DAIFMT_PCM_L unless someone has an objection to that. 
> 
> I need to define it in sound/soc.h I notice the other defs as: 
> 
> #define SND_SOC_DAIFMT_I2S        0    /* I2S mode */
> #define SND_SOC_DAIFMT_RIGHT_J    1    /* Right justified mode */
> #define SND_SOC_DAIFMT_LEFT_J    2    /* Left Justified mode */
> #define SND_SOC_DAIFMT_DSP_A    3    /* L data msb after FRM or LRC
> */ 
> #define SND_SOC_DAIFMT_DSP_B    4    /* L data msb during FRM or LRC
> */
> #define SND_SOC_DAIFMT_AC97        5    /* AC97 */
> 
> so, could I add a line:
> 
> #define SND_SOC_DAIFMT_PCM_L    6    /* PCM Long Sync Format*/ 
> 
> ..without too many hassles? Just want to make sure i am not violating
> a standard or something. 
> 

Do you have a link to any timing diagrams for this format ?

Liam
