From: Anton Yashin <fynjy-007@yandex.ru>
Subject: Re: Problem with PPH plugin
Date: Thu, 21 Jan 2010 15:04:36 +0000 (UTC)
Message-ID: <loom.20100121T160205-331@post.gmane.org>
References: <hj4rap$ofp$2@ger.gmane.org>
	<s5hr5pljj7a.wl%tiwai@suse.de>	<loom.20100120T231250-50@post.gmane.org>	<s5hfx60csn8.wl%tiwai@suse.de>
	<loom.20100121T115627-815@post.gmane.org>
	<4B5864CE.4090807@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D0EBE243AB
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 16:05:25 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXyb3-00078z-Ut
	for alsa-devel@alsa-project.org; Thu, 21 Jan 2010 16:05:22 +0100
Received: from 95-29-147-9.broadband.corbina.ru ([95.29.147.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 16:05:21 +0100
Received: from fynjy-007 by 95-29-147-9.broadband.corbina.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 16:05:21 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie <gmane <at> colin.guthr.ie> writes:

> 
> I'm not sure where Raymond sees flashsupport.c...
> 
> Could it be that you have libflashsupport.so (probably in /usr/lib/) on
> your system somewhere? If so you should try removing it (e.g. finding
> which package owns the file - rpm -qf <file> - and then removing the
> package) and see if the problem goes away.
> 
> It's used to extend Flash player and I guess it could be cocking up
> somewhere or other.
> 
> Col
> 

Hi

#LANG=C find / | grep libflashsupport
find: `/home/anton/.gvfs': Permission denied

May be this some internal features of flash player?

Thanks,

Anton.
