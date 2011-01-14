From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: question on snd_soc_jack_report
Date: Fri, 14 Jan 2011 17:10:01 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0C1E3E0@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 26CA2103B98
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 12:40:06 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using snd_soc_jack_report and I send the parameter as follows to report
headphones.

struct snd_soc_jack *soc_jack;
snd_soc_jack_report (soc_jack, SND_JACK_HEADPHONE, SND_JACK_HEADPHONE);

I don't find the reporting to be happening. When I looked at the snd_jack_report 
code, I found that jack->type needs to be set and that was not being set.
So when I added the following line in my code, it started reporting.
soc_jack->jack->type = SND_JACK_HEADPHONE;

Is it expected that the driver sets the 'type' of the instance of 'snd_jack' inside 
snd_soc_jack structure. I was actually thinking that snd_soc_jack_report would 
need to do this.

I did not find any other drivers doing that. Is there something that I am 
missing?

Also, to report button press events, I had to add the following line of code
soc_jack->jack->key[0] = BTN_0;
Is this also an expected thing to be set.

-Harsha
