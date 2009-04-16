From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] hdspm: native float
Date: Thu, 16 Apr 2009 13:48:46 +0200
Message-ID: <49E71B1E.8020306@ladisch.de>
References: <1239729105.18545.12.camel@x200.watzmann.local>	
	<49E701E6.3090500@ladisch.de>
	<1239878648.10715.2.camel@x200.watzmann.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D28BC1039B2
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:48:42 +0200 (CEST)
In-Reply-To: <1239878648.10715.2.camel@x200.watzmann.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> > > > 	/* Switch to native float format if requested */
> > > > ...
> > > > 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
> > 
> > This looks like a global change.  What happens when playback and
> > recording want to use different formats?
> 
> It is a global change. The only use case is for jack, and jack doesn't
> use different formats for input/output.

"Using aplay + arecord" is a second use case.  :-)

Anyway, at least add a check that the formats are actually the same
(like the checks for sample rate and period size).


Best regards,
Clemens
