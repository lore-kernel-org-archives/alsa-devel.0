From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Triggering a DAPM widget event
Date: Thu, 27 Jan 2011 09:09:39 +0200
Message-ID: <4D411A33.3080205@nokia.com>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.	local><20110126165347.GB10759@sirena.org.uk><39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>	<20110126182754.GJ8501@opensource.wolfsonmicro.com>
	<39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 348242440E
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 08:09:43 +0100 (CET)
In-Reply-To: <39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Harrod, John" <john.harrod@philips.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 01/26/11 22:38, ext Harrod, John wrote:
>> What is your actual problem here?
> =

> I have a speaker widget (snd_soc_dapm_spk) whose event handler only recei=
ves a
> SND_SOC_DAPM_PRE_PMD event when the pcm is closed.

Events on widgets are (among others):
SND_SOC_DAPM_PRE_PMU: will be sent before the widget power up
SND_SOC_DAPM_POST_PMU: will be sent after the widget power up
SND_SOC_DAPM_PRE_PMD: will be sent before the widget power down
SND_SOC_DAPM_POST_PMD: will be sent after the widget power down

The *_PMU events are triggered whenever the widget is going to be
powered up:
stream start, within prepare time;
complete bypass, or loopback path

The *_PMD events are triggered whenever the widget is going to be
powered down:
bypass, or loopback path is disabled
After the stream has been stopped/closed.
 In case of playback the power down is delayed (5 sec by default)
 In case of capture the power down is instant.

If you stop, and restart the playback stream within 5 sec, events will
not be triggered on the widgets, since they are still powered.

-- =

P=E9ter
