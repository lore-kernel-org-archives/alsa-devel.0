From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: _mmap_playback_avail() short
Date: Mon, 28 Nov 2011 22:12:53 +0100
Message-ID: <4ED3F955.4090904@ladisch.de>
References: <201110311738.52213.gineera@aspect135.co.uk>	<201111031003.10016.gineera@aspect135.co.uk>
	<201111251510.27592.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DF7AB244A9
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:13:07 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 255E221047
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 16:13:07 -0500 (EST)
In-Reply-To: <201111251510.27592.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
>> It seems that at a period boundary event snd_pcm_mmap_playback_avail() may
>> not return a full period size, but is a few bytes short.  If avail_min is
>> set to one whole period (which Portaudio at present does),
>> snd_pcm_direct_poll_revents() zeroes the revent due to the check of
>> snd_pcm_mmap_playback_avail() against avail_min.  POLLOUT is therefore not
>> indicated, and the app does not write any data, causing an Xrun.

This sounds like a bug in the rate plugin.  snd_pcm_rate_sync_hwptr()
tries to properly align pointer values at period boundaries, but its
algorithm doesn't work when a period does not start at the buffer start
(i.e., when the number of periods is not an integer), and this
restriction is not actually enforced by snd_pcm_rate_hw_refine_cchange().

As a workaround, try snd_pcm_hw_params_set_periods_integer().


Regards,
Clemens
