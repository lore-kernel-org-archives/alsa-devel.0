From: Sebastien LEDUC <sebastien.leduc@st.com>
Subject: Re: question on snd_soc_dai_link_event
Date: Wed, 21 Nov 2012 18:56:55 +0100
Message-ID: <9C1683ABA24673439FCD019782C9F4BBDE4BD6E569@SAFEX1MAIL1.st.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
 <20121026170142.GZ18814@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog104.obsmtp.com (eu1sys200aog104.obsmtp.com
 [207.126.144.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 23FB12650EE
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 18:57:33 +0100 (CET)
In-Reply-To: <20121026170142.GZ18814@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam  Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

One further question on the dai_link widget mechanism.

Currently the code in soc_probe_link_dais, the code will call snd_soc_dapm_new_pcm
to create the dai_link widget and the routes.

For a capture stream, it creates the following routes:
Cpu_dai widget -> dai_link widget -> codec_dai widget

And for a playback stream:
Codec_dai widget -> dai_link widget -> cpu_dai widget

Shouldn't it be the opposite directions in both cases?
Or did I miss something?

Thanks
Regards
Sebastien
