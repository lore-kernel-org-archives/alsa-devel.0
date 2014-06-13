From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Date: Fri, 13 Jun 2014 11:50:50 +0800
Message-ID: <20140613035049.GB15609@MrMyself>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
 <20140613032119.GA15609@MrMyself>
 <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 765B72610A7
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 06:07:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOZdJXUUz2bufcYmt9U-x0bic6XU68VHLOiPPsHoEdSZmnisZw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 12, 2014 at 10:44:48PM -0500, Timur Tabi wrote:
> On Thu, Jun 12, 2014 at 10:21 PM, Nicolin Chen
> <Guangyu.Chen@freescale.com> wrote:
> 
> > It compiles well with my ARM cross compiler. I guess it might be related
> > to the compiler's version? But we should fix it anyway. Would you mind if
> > I submit a patch? Or you do it directly?
> 
> I just submitted a patch, but I can't test the code since I don't have
> any boards that configure the SSI into master mode, so this function
> is never called.

I just tested it with i.MX platform. It still works.

Thank you,
Nicolin
