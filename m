From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_soc_jack_report
Date: Fri, 14 Jan 2011 12:00:23 +0000
Message-ID: <20110114120022.GB20846@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE08C0C1E3E0@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5864103848
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 13:00:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C0C1E3E0@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 14, 2011 at 05:10:01PM +0530, Harsha, Priya wrote:

> struct snd_soc_jack *soc_jack;
> snd_soc_jack_report (soc_jack, SND_JACK_HEADPHONE, SND_JACK_HEADPHONE);

> I don't find the reporting to be happening. When I looked at the snd_jack_report 
> code, I found that jack->type needs to be set and that was not being set.
> So when I added the following line in my code, it started reporting.
> soc_jack->jack->type = SND_JACK_HEADPHONE;

> Is it expected that the driver sets the 'type' of the instance of 'snd_jack' inside 
> snd_soc_jack structure. I was actually thinking that snd_soc_jack_report would 
> need to do this.

> I did not find any other drivers doing that. Is there something that I am 
> missing?

No, you should be passing the full set of capabilities for the jack in
when you call snd_soc_jack_new().  It's not possible to change the
capabilities dynamically at runtime, these need to be fixed when
registering the jack.

> Also, to report button press events, I had to add the following line of code
> soc_jack->jack->key[0] = BTN_0;
> Is this also an expected thing to be set.

You've not said where you did this but the API for configuring button
types is snd_jac_set_key().  BTN_0 should be being used as a default
when the jack is registered if nothing has been explicitly configured
(see snd_jack_register()).  If you're not specifying the capabilities as
your above issue suggests this won't happen.
