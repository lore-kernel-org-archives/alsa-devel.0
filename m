From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 01 Oct 2009 15:34:46 +0300
Message-ID: <1254400486.2472.50.camel@eenurkka-desktop>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<20091001103714.GB14417@sirena.org.uk>
	<1254394869.2472.25.camel@eenurkka-desktop>
	<1254398184.2472.45.camel@eenurkka-desktop>
	<20091001120931.GF19998@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 861A510393F
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:35:53 +0200 (CEST)
In-Reply-To: <20091001120931.GF19998@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-01 at 14:09 +0200, ext Mark Brown wrote:
> On Thu, Oct 01, 2009 at 02:56:24PM +0300, Eero Nurkkala wrote:
> 
> > Actually, in this case: (kernel 2.6.28)
> 
> That's rather old...
> 
Yes, but I've been mirroring things with 2.6.31..

> > But if it didn't come from snd_soc_dapm_put_volsw(),
> > but instead:
> > close_delayed_work() ->
> > snd_soc_dapm_stream_event() ->
> > dapm_power_widgets() ->
> > dapm_set_pga()
> > then the codec->mutex is not taken,
> > and the bug presented in the patch is out there, no?
> 
> Right, so close_delayed_work() needs to lock the card while it runs.

Can't really do that, because snd_soc_dapm_stream_event()
will try to take codec mutex again. Tried the following:

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2071,9 +2071,9 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec
*codec,
 			}
 		}
 	}
-	mutex_unlock(&codec->mutex);
 
 	dapm_power_widgets(codec, event);
+	mutex_unlock(&codec->mutex);
 	dump_dapm(codec, __func__);
 	return 0;
 }


Does that make any sense?

- Eero
