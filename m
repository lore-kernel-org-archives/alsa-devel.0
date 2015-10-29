From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 09:19:43 -0700
Message-ID: <CAG5mAdxY1+Db0VnSJ0CTY=pnF-8VCGd4KByhGxHAsdZn0Jw6cQ@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
 <56323D3F.4080708@tekno-soft.it>
 <CAG5mAdywpA1af60wTwgPWMPGWmz7cYDHOycbSUeWHF3Znyr78w@mail.gmail.com>
 <5632431D.1020001@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 720452606A7
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 17:20:03 +0100 (CET)
Received: by wmll128 with SMTP id l128so27828239wml.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 09:20:03 -0700 (PDT)
In-Reply-To: <5632431D.1020001@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 9:02 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 10/29/2015 04:54 PM, Caleb Crome wrote:
>> On Thu, Oct 29, 2015 at 8:37 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>> On 10/29/2015 03:55 PM, Caleb Crome wrote:
>>> I don't know actually how the two events types will behaves from the SDMA point of view.
>> The 35 and 36 are for Dual fifo mode only, and no current system (with
>> fsl_ssi.c anyway) uses dual fifo mode.  How do I know?  Because the
>> it's definitely broken in the fsl_ssi.c.  I was just about to report
>> that bug.
>
> Ah! Thanks! The reference manual is really clear to explain it :-D !
>
>> hint:  fsl_ssi.c:  if (ssi_private->use_dma && !ret && dmas[2] ==
>> IMX_DMATYPE_SSI_DUAL) {
>> should read  if (ssi_private->use_dma && !ret && dmas[3] ==
>> IMX_DMATYPE_SSI_DUAL) {

Oops, nevermid.  I was looking at that wrong.  It's correct as is.
-Caleb
