From: dustin@seznam.cz
Subject: Multichannel capture support in E-MU 1212
Date: Tue, 15 May 2007 15:26:34 +0200 (CEST)
Message-ID: <9723.25058-11506-1683663200-1179235594@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxl.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id D64C02482D
	for <Alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 15:26:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am working together with Ctirad on supporting more capture channels in E-MU1212. So far we have managed to increase the number of channels from the default of 8 to 16 (A_FXWC2 = 0xffffffff, added new  snd_emu10k1_audigy_dsp_convert_32_to_2x16 calls in emufx.c), there is still a number of issues to solve.

I would like to get your opinion on the form of adding this support to the module. The options are either hard-coding the 16 capture channels into the code, assuming that users would prefer as many channels as possible and do the routing in jack, or introducing a module parameter emu1010-capture-channels (range e.g. 1 to 16 - untested yet) and leaving the  default number at the existing 8.

Furthermore, the PCMs other than efx seem to be of no use for the EMU-1x1x models, probably fairly confusing for new users. Would you find it OK, if  they were removed for this specific card (if (emu->card_capabilities->emu1010)), keeping only the playback and capture PCM id 2?

Thanks a lot for your suggestions. Based on them, I will prepare the patch (with comments on what we found out about the card - it is a pitty that the driver has almost no big-picture comments on the supported cards' specifics, making new developers spend a number of long nights going through the nontrivial code and guessing).

Pavel.
