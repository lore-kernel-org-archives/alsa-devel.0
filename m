From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC legacy i2c client driver probing issue
Date: Wed, 4 May 2011 11:38:05 +0100
Message-ID: <20110504103804.GA20227@sirena.org.uk>
References: <9383297B60843144AC17878B479520F1164B62450F@SJEXCHCCR01.corp.ad.broadcom.com>
	<4DC0DC4D.4020905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D8F210381B
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 12:38:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC0DC4D.4020905@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Feng Ye <fye@broadcom.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 10:25:41AM +0530, rajeev wrote:
> On 5/2/2011 11:48 PM, Feng Ye wrote:

Please always CC maintainers on mails, and fix your MUA to word wrap
within paragraphs so your mails are legible.  I've reflowed your text.

> > I use kernel version 2.6.27, and wm8750 external codec. The wm8750.c

Version 2.6.27 is extremely old, none of these issues exist in current
kernels.

> > In our i2c bus driver, we used i2c_register_board_info() with a
> > static i2c_board_info structure. And then i2c_add_numbered_adapter()
> > is called.

With these very old kernels you shouldn't do this.  With modern kernels
you can register the I2C devices normally.
