From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: TLV mapping for tpa6140a2
Date: Tue, 4 May 2010 12:33:26 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1005041208560.2316@tumpelo.nmp.nokia.com>
References: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9379B2442A
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 11:32:40 +0200 (CEST)
In-Reply-To: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


On Tue, 4 May 2010, Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Both tpa6130a2, and tpa6140a2 is supported by the
> same driver, but the gain dB scaling is different on
> the amplifiers.
>
> Provide different mixer control for the chips with correct
> TLV mapping.
>
> User space will see:
> "TPA6130A2 Headphone Playback Volume" in case of 6130
> "TPA6140A2 Headphone Playback Volume" in case of 6140
>
> The way machine drivers are using this amplifier remained
> the same.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Uh, I wonder how I missed that one. Anyway, look good to me.

Reviewed-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
