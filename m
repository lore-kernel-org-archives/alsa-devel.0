From: Florian Faber <faber@faberman.de>
Subject: Re: [PATCH] hdspm: native float
Date: Thu, 16 Apr 2009 14:12:21 +0200
Message-ID: <1239883941.10715.26.camel@x200.watzmann.local>
References: <1239729105.18545.12.camel@x200.watzmann.local>
	<49E701E6.3090500@ladisch.de>
	<1239878648.10715.2.camel@x200.watzmann.local>
	<49E71B1E.8020306@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.guglielmo.biz (smtp.guglielmo.biz [217.18.210.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 89855103941
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 14:12:22 +0200 (CEST)
In-Reply-To: <49E71B1E.8020306@ladisch.de>
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

> > It is a global change. The only use case is for jack, and jack doesn't
> > use different formats for input/output.
> "Using aplay + arecord" is a second use case.  :-)

And they would willingly choose different formats?

> Anyway, at least add a check that the formats are actually the same
> (like the checks for sample rate and period size).

Ok.

I just fixed a bug regarding the clock source anyway
(LAC-live-debugging :).

-- 
Flo
