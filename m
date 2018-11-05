From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343:
	Faulty error check
Date: Mon, 5 Nov 2018 13:33:41 +0000
Message-ID: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092069089.outbound.protection.outlook.com [40.92.69.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5D52678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 14:33:42 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "olivier.moysan@st.com" <olivier.moysan@st.com>, "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "alexandre.torgue@st.com" <alexandre.torgue@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello there,

linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343]: (style) Checking if unsigned variable 'div' is less than zero.

Source code is

        div = stm32_sai_get_clk_div(sai, parent_rate, rate);
        if (div < 0)
                return div;

Suggest store return value from function in int local variable, test it
and only then assign it into an unsigned variable.

Regards

David Binderman
