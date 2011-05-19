From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Setting invalid samplerate
Date: Thu, 19 May 2011 12:55:28 +0200
Message-ID: <4DD4F720.5090706@ladisch.de>
References: <4DD27C43.3050509@canonical.com>
	<s5hfwod5nz0.wl%tiwai@suse.de>	<4DD4E909.80108@canonical.com>
	<s5htycr0zuf.wl%tiwai@suse.de>
	<13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 35FA91037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 12:53:10 +0200 (CEST)
In-Reply-To: <13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>, Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Torsten Schenk wrote:
> I'm working on the driver for the dmx 6fire usb.  ... 
> since Ubuntu 11.04, I get complaints about the card not working anymore,

I'd guess that would be commit 82d90313980b:
| ALSA: USB: 6fire: signedness bug in usb6fire_pcm_prepare()
| 
| rt->rate is an unsigned char so it's never equal to -1.  It's not a huge
| problem because the invalid rate is caught inside the call to
| usb6fire_pcm_set_rate() which returns -EINVAL.  But if we fix the test
| then it prints out the correct error message so that's good.
| 
| Signed-off-by: Dan Carpenter <error27@gmail.com>
| 
| --- a/sound/usb/6fire/pcm.c
| +++ b/sound/usb/6fire/pcm.c
| @@ -493,13 +493,12 @@ static int usb6fire_pcm_prepare(struct snd_pcm_substream *alsa_sub)
|  	sub->period_off = 0;
|  
|  	if (rt->stream_state == STREAM_DISABLED) {
| -		rt->rate = -1;
|  		for (i = 0; i < ARRAY_SIZE(rates); i++)
|  			if (alsa_rt->rate == rates[i]) {
|  				rt->rate = i;
|  				break;
|  			}
| -		if (rt->rate == -1) {
| +		if (i == ARRAY_SIZE(rates)) {
|  			mutex_unlock(&rt->stream_mutex);
|  			snd_printk("invalid rate %d in prepare.\n",
|  					alsa_rt->rate);

This fixed not a bug but just a symptom of the actual bug, that rt->rate
is not signed.

There are still "rt->rate = -1" initializations, and usb6fire_pcm_open()
then does:

	if (rt->rate >= 0)
		alsa_rt->hw.rates = rates_alsaid[rt->rate];


Regards,
Clemens
