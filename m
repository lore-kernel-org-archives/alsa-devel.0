From: "Nobin Mathew" <NMathew@sirf.com>
Subject: Implementing Priority Based Device ALSA device
	interface. ALSA drivers
Date: Tue, 1 May 2007 22:06:24 +0530
Message-ID: <013B1C915F9462459242424413ABB264529471@bnglmail.sirf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bnglmail.sirf.com (unknown [125.16.138.30])
	by alsa0.perex.cz (Postfix) with SMTP id 9DF5824429
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2007 18:36:28 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Friends,

 

I am a new to ALSA, I am developing a ALSA ASoC driver.

 

Now driver can support both audio playback and capture.

 

Now the problem is handling of application with different priority.

We have three applications say app1, app2 and app3; they are in
increasing order of priority.

 

One scenario of app1 and app2 is below

 

If app2 is accessing the device while app1 playback is going on, then
app1 should stop (clearly do pause) playback and allow app2 to playback,
and app1 should continue playback when app2 exit.

 

The requirement is that there should be no changes to apps, except the
devices each app will access. There will be no daemons in user space
which will handle priority.

 

For that i implemented three interfaces like pcmC0p0, pcmC0p1 and
pcmC0p2 there are in increaing order of priority.

All these interfaces will access the same audio hardware. Only thing is
each will have separate ALSA kernel buffer.

 

In this implementation app1 will always access pcmC0p0, and app2 pcmC0p1
like that.

 

What i am doing is, in driver i will pause the pcmC0p0 substream using
snd_pcm_pause() when pcmC0p1 is accessed.

Same for pcmc0p2.

 

This call will change the state of pcmc0p0 substream to
SNDRV_PCM_STATE_PAUSED, and this call should notify the user app also.
When app2 playback is over i will change the state of pcmC0p0 substream
to SNDRV_PCM_STATE_RUNNING by another call to snd_pcm_pause().

 

This implementation requires some minor modifications in the ALSA lib
and ALSA app (handling of PAUSE from kernel).

 

But what i found is kernel is not notifying the user using
snd_timer_notify() (user call back) function because i am using the
substream timer snd_pcm_timer which is there in pcm_timer.c. For this
timer SNDRV_TIMER_HW_SLAVE flag is set so it will not notify the user. 

 

What is the use of these timers in ALSA?

 

Am i going wrong?

 

Is my design correct?

 

Can u suggest some alternate design?

 

 

 

 

Sorry for my poor English.

 

Thanks 

Nobin Mathew
