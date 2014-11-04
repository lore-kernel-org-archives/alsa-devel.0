From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt286: reduce power consumption
Date: Tue, 4 Nov 2014 05:18:19 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70101E1B3@RTITMBSV03.realtek.com.tw>
References: <1414738336-17371-1-git-send-email-bardliao@realtek.com>
 <20141031110851.GL18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2527A2605D6
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 06:18:23 +0100 (CET)
In-Reply-To: <20141031110851.GL18557@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, October 31, 2014 7:09 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou
> Subject: Re: [PATCH] ASoC: rt286: reduce power consumption
> 
> 
> Please also fix the comment style in this driver - spaces around the /* */

Do you mean something like:
-		/* power LDO1 */
+		/*power LDO1*/

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
