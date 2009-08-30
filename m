From: Halim Sahin <halim.sahin@freenet.de>
Subject: really no idea? Re: a11y: howto reduce latency with
	alsa's dmix plugin?
Date: Sun, 30 Aug 2009 16:13:38 +0000 (UTC)
Message-ID: <20090830161338.GA13405@halim>
References: <20090823095517.GA27741@halim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AC42C244E9
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Aug 2009 18:13:55 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Mhn2O-0006G0-Jw
	for alsa-devel@alsa-project.org; Sun, 30 Aug 2009 18:13:52 +0200
Received: from pd9e0f333.dip.t-dialin.net ([217.224.243.51])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2009 18:13:52 +0200
Received: from halim.sahin by pd9e0f333.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2009 18:13:52 +0200
Content-Disposition: inline
In-Reply-To: <20090823095517.GA27741@halim>
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

On So, Aug 23, 2009 at 09:55:18 +0000, Halim Sahin wrote:
> Hello,
> Is there a way to reduce latency on audiocard if the dmix plugin is in
> use?
> I am asking because there is a strange problem with asistive
> technologies which are outputing through alsa.
> E. G. speech-dispatcher takes almost a half sec to stop the
> speech-synthesizer.
> If the user navigates quickly through menus, there are simultane outputs
> at a time.
> (tested with an usb logitech headset, snd-intel8x0 based card,
> snd-hda-intel).
> The same problem can be reproduced by running mplayer with alsa output
> driver and pressing
> quickly left/right arrow.
> You should hear several samples at a time.
> 
> Using an sblive card which doesn't use dmix doesn't have such problems.
> 
> Using the dmix plugin should audio much faster to avoid this problem.
> 
> Please help!!!
> Regards
> Halim

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
