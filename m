From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: DMA buffer gets played only once
Date: Wed, 05 Sep 2007 11:04:39 +0200
Message-ID: <1188983079.7844.1208974467@webmail.messagingengine.com>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2742F103803
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 11:04:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46DE4AB1.20206@hrz.tu-chemnitz.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Franke <markus.franke@s2002.tu-chemnitz.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Markus Franke wrote:
> It seems like that after the 8th period is transferred
> pcm_trigger(TRIGGER_STOP) isn't getting called. 

Indeed.  The stop trigger is called when the entire stream is
to be stopped.

When the start trigger has been called, the hardware (or the driver) is
responsible for playing the ring buffer _repeatedly_.   If the hardware
doesn't do this automatically, the driver has to reprogram it.


HTH
Clemens
