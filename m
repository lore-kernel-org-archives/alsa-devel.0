From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Dsnoop-plugin buffer sizes
Date: Mon, 14 Mar 2011 11:52:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103141143380.4805@eeebox2.perex-int.cz>
References: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
	<alpine.LNX.2.00.1103141107030.4805@eeebox2.perex-int.cz>
	<A612847CFE53224C91B23E3A5B48BAC749EE00F816@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 027DE103810
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:52:33 +0100 (CET)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749EE00F816@xmail3.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Magnus Olsson <magnus.olsson@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2011, Magnus Olsson wrote:

> This output is captured when running periods_min=4.
>
> Direct Snoop PCM
>  buffer_size  : 8000
> Hardware PCM card 0 'X4 AIC3104 Dual' device 0 subdevice 0
>  buffer_size  : 8192

This may be OK. The buffer sizes between plugins can differ.
What are the parameters for direct record ? (use 'arecord -v' with plughw 
device).

Also, you may try to force the buffer size to 8000 for dsnoop (use 
period_size 2000, periods 4) in your dmix slave configuration, for 
example:

 	type dmix
 	slave {
 		period_size 2000
 		periods 4
 	}

If this works, it's probably a bug in the driver.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
