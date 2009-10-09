From: <ext-Eero.Nurkkala@nokia.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 20:24:49 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D42977600E85F0CC9A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255093831.30157.207.camel@eenurkka-desktop>
	<200910091636.16126.peter.ujfalusi@nokia.com>,
	<20091009171941.GA20083@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D7CE103A7F
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 20:25:10 +0200 (CEST)
In-Reply-To: <20091009171941.GA20083@sirena.org.uk>
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
To: broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, eduardo.valentin@nokia.com
List-Id: alsa-devel@alsa-project.org


ext Mark Brown wrote:
> On Fri, Oct 09, 2009 at 04:36:16PM +0300, Peter Ujfalusi wrote:
> 
>> Well it is very unlikely that something like this could ever happen since the
>> tpa6130a2_channel_enable and the tpa6130a2_power is called when DAPM is
>> enabling/disabling the path. I think in a middle of enable or disable there
>> should not be any opposite operation running in DAPM...
> 
> DAPM guarantees single threadedness - DAPM itself would get confused if
> there were more than one power update in progress at once.

I guess there's (or may be) an exception though. I think I've seen some
strangeness with the close_delayed_work() -> and simultaneous mixer tweaking:

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/021671.html

This is just an example:

Userspace thread:
snd_soc_dapm_put_volsw() ->
mutex_lock(&widget->codec->mutex); ->
dapm_mixer_update_power() ->
dapm_power_widgets() -> PRE_EMTED in damp_power_widgets()

Workqueue thread:
close_delayed_work()
snd_soc_dapm_stream_event()
mutex_lock(&widget->codec->mutex);
mutex_unlock(&widget->codec->mutex);
dapm_power_widgets() -> PRE_EMTED back to Userspace thread

So there can and does run two dapm_power_widgets() when stars
point to the right direction. That's when delayed work is at
damp_power_widgets, and then preempted to
the userspace thread.  May that isn't related to this TPA though, but
I think I'll silently review the code so that the "stars are forced to
point to the right direction".

(but yeah, these are just my observations, don't worry about them)
