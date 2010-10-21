From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Questions - MUTE and PLAYBACK RATE
Date: Thu, 21 Oct 2010 17:50:07 +0200
Message-ID: <4CC0612F.4010402@ladisch.de>
References: <102125.36145.qm@web120512.mail.ne1.yahoo.com>
	<4CC03492.30908@ladisch.de>
	<385567.69220.qm@web120509.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id DBA2E1038B7
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 17:48:56 +0200 (CEST)
In-Reply-To: <385567.69220.qm@web120509.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Xavi Alexis <xamalek@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Xavi Alexis wrote:
> What is the SPECIFIC function to reduce the BUFFER size?

The buffer size (or the equivalent time) is a parameter to the
snd_pcm_set_params() or one of the snd_pcm_hw_params_set_buffer_*
functions.


Regards,
Clemens
