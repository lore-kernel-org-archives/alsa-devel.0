From: <jukka.hynninen@vaisala.com>
Subject: ASoC: pll/clkdiv issue with simple-card driver
	&	WM8510/Atmel SSC
Date: Mon, 25 Sep 2017 14:31:58 +0000
Message-ID: <2b159e716de24bf6abda7e1707376fd7@HEL-EXCH-02.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com
 [193.143.230.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D9D266AF8
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 16:34:20 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> I think simple-card doesn't have .set_pll / .set_clkdiv feature today.
> You can add such feature if needed.

Implementing such a feature into simple-card driver alone might not be possible, as the PLL output frequency and resulting MCLK/BCLK divisors are codec dependent.

I wonder if the right place would be within the codec driver, after all? The machine code would just request a certain bitclock frequency and frame length in case the codec is selected to be the clock master.

Is this in line with ASoC architecture?


-Jukka
