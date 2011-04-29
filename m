From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Decibel range / value from  snd_hctl_elem_t
Date: Fri, 29 Apr 2011 08:15:49 +0200
Message-ID: <4DBA5795.10902@ladisch.de>
References: <4DB9B629.8090700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C0C851037F5
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 08:14:27 +0200 (CEST)
In-Reply-To: <4DB9B629.8090700@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sebastian H. wrote:
> I'm stuck with the hctl interface.
> What is the best way to get
> 1. the decibel range from a snd_hctl_elem_t
> 2. the decibel value from a snd_hctl_elem_t

The hctl stuff is just a thin wrapper over the ctl stuff, so call
snd_hctl_ctl and snd_hctl_elem_get_id, then snd_ctl_*dB*.

> Possibly related: What does TLV stand for?
> http://de.wikipedia.org/wiki/Type-Length-Value ?

Yes; but you should let alsa-lib parse it.


Regards,
Clemens
