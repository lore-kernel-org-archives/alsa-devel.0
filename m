From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to handle buffer underrun in a softsynth
Date: Tue, 29 Nov 2011 11:46:38 +0100
Message-ID: <4ED4B80E.3050106@ladisch.de>
References: <alpine.DEB.2.00.1111281636560.13399@anubis.informatik.uni-halle.de>
	<4ED3EC1C.70100@ladisch.de>
	<alpine.DEB.2.00.1111290913010.27304@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id EEA3C1039B0
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 11:45:49 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1E97A218A9
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 05:45:47 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA2FE8E0195
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 05:45:46 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1111290913010.27304@anubis.informatik.uni-halle.de>
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

Henning Thielemann wrote:
> I must somehow map timestamps of ALSA sequencer events to sample
> counts in order to let notes start within a sample block. JACK claims
> to synchronize everything and it runs on top of ALSA - how does it
> manage synchronization between MIDI and PCM?

It takes timestamps whenever ALSA reports a period boundary.  (This
requires that the code doesn't run too late, i.e., that underruns do
not happen.)  There may be some DLL to smooth out the measurements.

The timestamps can be made more reliable by using a recent enough kernel
and alsa-lib, and enabling timestamps for PCM pointer updates with
snd_pcm_sw_params_set_tstamp_mode(); then snd_pcm_status() will return
both the buffer position and the corresponding timestamp.

> How can I detect a buffer underrun when I disabled underrun detection?

The avail value is larger than the buffer size.


Regards,
Clemens
