From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to show error message
Date: Fri, 12 Nov 2010 09:40:16 +0100
Message-ID: <4CDCFD70.50107@ladisch.de>
References: <AANLkTinOjDRDiyA1zujUj+hYN5s+eq0u-1bZn=mxKGfp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 43E5C103916
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:38:23 +0100 (CET)
In-Reply-To: <AANLkTinOjDRDiyA1zujUj+hYN5s+eq0u-1bZn=mxKGfp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: s n <sn.esubscription@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

s n wrote:
> How to show an error message in alsamixer (gnome and non-gnome) version?

The alsamixer program in the alsa-utils package uses ncurses, not Gnome.
It uses the show_alsa_error function in textbox.c.


Regards,
Clemens
