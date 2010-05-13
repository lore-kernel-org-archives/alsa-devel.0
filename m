From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Thu, 13 May 2010 12:05:19 +1200
Message-ID: <hsffo2$7du$1@dough.gmane.org>
References: <20100512013015.752623810@intel.com>	<20100512015713.762299923@intel.com>	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>	<s5htyqdsg0w.wl%tiwai@suse.de>
	<20100512083950.GB11001@localhost>	<s5hbpclsdbu.wl%tiwai@suse.de>
	<20100512100632.GA13304@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D14EA245E1
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 02:05:35 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OCLvg-0004Wk-OO
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 02:05:32 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 02:05:32 +0200
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 02:05:32 +0200
In-Reply-To: <20100512100632.GA13304@localhost>
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

On 12/05/10 22:06, Wu Fengguang wrote:

> Can I ask a dumb question? Currently I select the target playback
> device with the -D option:
> 
>         speaker-test -Dhw:0,3 
> 
> How can I do the job when PCM substreams are used?

         speaker-test -Dhw:0,0,3
