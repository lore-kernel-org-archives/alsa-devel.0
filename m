From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH] ASoC: davinci: bug fixes for DM365 voice
	codec driver
Date: Wed, 20 Jul 2011 17:49:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DC70CBB@dbde02.ent.ti.com>
References: <1311158730-12412-1-git-send-email-sudhakar.raj@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DC70C65@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id B2B98243A5
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 14:19:42 +0200 (CEST)
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6KCJciX017588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2011 07:19:41 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DC70C65@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Sekhar,

On Wed, Jul 20, 2011 at 17:04:55, Nori, Sekhar wrote:
> Hi Sudhakar,
> 
> On Wed, Jul 20, 2011 at 16:15:30, Rajashekhara, Sudhakar wrote:
> > This patch fixes the following bugs found in DaVinci voice codec driver.
> > 
> > a. According to DM365 voice codec data sheet at [1], before starting
> >    recording or playback, ADC/DAC modules should follow a reset and
> >    enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
> >    the module and clearing the bit to 0 will enable the module. But the
> >    driver seems to be doing the reverse of it.
> > 
> > b. In davinci_vcif_trigger() function, a break() statement was missing
> >    causing the davinci_vcif_stop() function to be called as a fallback
> >    after calling davinci_vcif_start().
> 
> These should be two different patches. Also, please CC the ALSA maintainers.
> 

I'll split the patches and resend them.

Regards,
Sudhakar
