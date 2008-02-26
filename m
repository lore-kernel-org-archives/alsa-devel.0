From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Output widgets
Date: Tue, 26 Feb 2008 11:07:41 +0000
Message-ID: <20080226110740.GC13449@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5ECA7103831
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 12:07:42 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 26, 2008 at 10:11:42AM +0100, Alexandre BOUIN wrote:

> DAPM WM8900 snd_soc_dapm_stream_event
> FM Transmitter: On  in 2 out 1
>  in  static FMOUT_R
>  in  static FMOUT_L

> I initialize FM Transmitter like this : 
> 	snd_soc_dapm_set_endpoint(codec, "FM Transmitter", 0);
> but it still enabled. Why ?

According to the above trace your FM transmitter is still reporting as
being connected.  Have you checked to ensure that your your call to
configure the transmitter is happening after your board widgets have
been registered?
