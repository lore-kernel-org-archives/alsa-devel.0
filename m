From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Any wigets for ADC to DAC ?
Date: Fri, 28 Mar 2008 16:39:48 +0100
Message-ID: <37528.4890797504$1206718885@news.gmane.org>
References: <47ED0038.9020808@acdstar.com>
	<20080328150256.GA16855@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 7C97024765
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 16:40:13 +0100 (CET)
In-Reply-To: <20080328150256.GA16855@sirena.org.uk>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'ALSA-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

In intern, we're still using WM8900 codec. We'd like to know in ASoC layer,
there is a widget to declare a possible audio path between ADC and DAC.

By the way, we could power on all necessary widget to use ADCtoDAC Sidetone,
without dealing with another audio path or start pcm on capture/playback.

Thanks and regards,
Alex.
