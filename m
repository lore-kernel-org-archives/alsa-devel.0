From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: overrun in case of record
Date: Wed, 07 Sep 2011 10:35:33 +0200
Message-ID: <4E672CD5.80508@ladisch.de>
References: <4E65E934.2070706@st.com>	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 90A2B103833
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 10:35:42 +0200 (CEST)
In-Reply-To: <4E66EFC3.2070706@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Rajeev kumar wrote:
> I analyzed the bug and found that if I use arecord  in non-blocking
> mode, it works fine.

In theory, with a correct driver, using non-blocking mode should not
make any difference.

All the symptoms indicate that the pointer callback and/or the calling
of snd_pcm_period_elapsed is somehow wrong.


Regards,
Clemens
