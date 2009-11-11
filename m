From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: alsa-info: problem hda-intel based card
Date: Wed, 11 Nov 2009 17:48:17 +0100
Message-ID: <20091111164817.GA30694@gentoo.local>
References: <20091030132214.GA18477@gentoo.local>
	<s5hy6mju38e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B48972452C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 17:48:53 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1N8GNH-00082F-OT
	for alsa-devel@alsa-project.org; Wed, 11 Nov 2009 17:48:51 +0100
Received: from pd9e3f2c8.dip.t-dialin.net ([217.227.242.200])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 17:48:51 +0100
Received: from halim.sahin by pd9e3f2c8.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 17:48:51 +0100
Content-Disposition: inline
In-Reply-To: <s5hy6mju38e.wl%tiwai@suse.de>
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

Hello,
On Fr, Nov 06, 2009 at 03:39:29 +0100, Takashi Iwai wrote:
> > 2. hdmi output isn't active in the alsa default output.
> > I can specify hw0,3 which works but it disables dmix.
> > So the problem is how to enable hdmi audio out this way that
> > aplay -Ddefault
> > can use all available outputs simultaniously (analog, sp/dif, and hdmi).
> 
> It's not supported because the analog and HDMI comes from different
> codecs.

are analog and sp/dif stuff coming from the  same codecs?
I am asking because analog and sp/dif are active in the default setup.
When using aplay I am getting signal on analog and sp/dif connectors.
So why not analog and HDMI?
Is there really no way to configure this with a custom ~/.asoundrc?

Thanks
Halim

> thanks,
> 
> Takashi

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
