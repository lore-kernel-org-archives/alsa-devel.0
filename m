From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH RFT] ASoC: sgtl5000: Fix up define for
	SGTL5000_SMALL_POP
Date: Wed, 22 Jul 2015 10:58:57 +0200
Message-ID: <1979834.BYYY6Fhuui@ws-stein>
References: <1437535665.17780.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id F3453260666
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 10:59:02 +0200 (CEST)
In-Reply-To: <1437535665.17780.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Filip Brozovic <fbrozovic@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 July 2015 11:27:45, Axel Lin wrote:
> Currently, below code actually does not update any bit because
> SGTL5000_SMALL_POP is 0.
> 
> snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL, SGTL5000_SMALL_POP, 1);
> 
> The SGTL5000_SMALL_POP should be BIT(0) rather than 0, fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I can not test this right now, but it seems appropriate.
Acked-By: Alexander Stein <alexander.stein@systec-electronic.com>

> Hi,
> I don't have h/w and datasheet, but the code looks obvious does not make
> sense. Can someone help to confirm and test if this patch?

The datasheet can be found online: http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=SGTL5000&fpsp=1&tab=Documentation_Tab

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
