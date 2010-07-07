From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems running "amixer"
Date: Wed, 07 Jul 2010 14:46:58 +0200
Message-ID: <4C347742.3050404@ladisch.de>
References: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C71C724496
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 14:47:05 +0200 (CEST)
In-Reply-To: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adish Kuvelker wrote:
> # ./amixer
> ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL default

Apparently, alsa-lib has not been installed correctly, i.e.,
/usr/share/alsa/alsa.conf and other files in this directory are missing.


Regards,
Clemens
