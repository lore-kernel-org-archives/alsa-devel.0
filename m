From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Snapshot alsa-utils-1.0.24.2.25.g9fa7c No
 user enum control support in alsa-lib
Date: Mon, 07 Nov 2011 22:03:17 +0100
Message-ID: <4EB84795.805@ladisch.de>
References: <4EB84389.9050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 857D624496
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2011 22:03:35 +0100 (CET)
In-Reply-To: <4EB84389.9050407@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: b0h3m4 <b0h3m4@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

b0h3m4 wrote:
> >alsa-lib-1.0.24.1.46.g15c6f.tar.bz2

This version contains snd_ctl_elem_add_enumerated.

> on alsa-utils I'm stuck at
> >checking for snd_ctl_elem_add_enumerated... no

Is the alsa-lib package installed correctly, i.e., is
snd_ctl_elem_add_enumerated defined in /usr/include/alsa/control.h
or in whatever include path you've told alsa-utils to use?


Regards,
Clemens
