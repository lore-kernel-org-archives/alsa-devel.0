From: Florian Faber <faber@faberman.de>
Subject: Re: [PATCH] hdspm: native float
Date: Thu, 16 Apr 2009 12:44:08 +0200
Message-ID: <1239878648.10715.2.camel@x200.watzmann.local>
References: <1239729105.18545.12.camel@x200.watzmann.local>
	<49E701E6.3090500@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.guglielmo.biz (smtp.guglielmo.biz [217.18.210.101])
	by alsa0.perex.cz (Postfix) with ESMTP id BA6CE10394D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:44:13 +0200 (CEST)
In-Reply-To: <49E701E6.3090500@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

> > > 	/* Switch to native float format if requested */
> > > ...
> > > 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
> This looks like a global change.  What happens when playback and
> recording want to use different formats?

It is a global change. The only use case is for jack, and jack doesn't
use different formats for input/output.


-- 
Flo
