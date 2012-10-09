From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: imx: clk: Split SSI clock into
 'ipg' and 'per'
Date: Tue, 9 Oct 2012 01:21:10 -0300
Message-ID: <CAOMZO5Beug=Db4_dW9ziNs-M=wUizrRSrDXMAXi0CXpUO1Nvzw@mail.gmail.com>
References: <1349725213-11354-1-git-send-email-fabio.estevam@freescale.com>
 <20121008214452.GA27665@pengutronix.de>
 <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ED83265211
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 06:21:11 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id n12so4486518oag.38
 for <alsa-devel@alsa-project.org>; Mon, 08 Oct 2012 21:21:10 -0700 (PDT)
In-Reply-To: <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

Sascha,

On Mon, Oct 8, 2012 at 8:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> On Mon, Oct 8, 2012 at 6:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>> I am not sure it's good to work around that issue in the ssi driver. We
>> could also just enable the clock in the clk driver as it seems to be a
>> ccm related issue.
>
> Yes, it would be better if we could fix this in clk-imx27 instead, but
> I was not able to provide such fix yet.

The ssi1_sel clock is defined as:

clk[ssi1_sel] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks,
ARRAY_SIZE(ssi_sel_clks));

,where ssi_sel_clks is:
static const char *ssi_sel_clks[] = { "spll", "mpll", }

,which matches with the mx27 reference manual.

How do we tell the clk api to select spll or mpll as the source for ssi_sel?

I understand how to do this from register level, but not from the api.

Thanks,

Fabio Estevam
