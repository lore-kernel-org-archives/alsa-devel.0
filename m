From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: alsa-compile.sh - easy testing of latest ALSA code
Date: Wed, 24 Feb 2010 09:47:35 +1300
Message-ID: <4B843EE7.2080602@audioscience.com>
References: <alpine.LNX.2.00.1002221725120.28127@eeebox2.perex-int.cz>	<s5h3a0s2wlu.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1002231003530.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B811B103899
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 21:48:39 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nk1gL-0004N0-N4
	for alsa-devel@alsa-project.org; Tue, 23 Feb 2010 21:48:37 +0100
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 21:48:37 +0100
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 21:48:37 +0100
In-Reply-To: <alpine.LNX.2.00.1002231003530.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 23 Feb 2010, Takashi Iwai wrote:
>> Just one point I noticed quickly is that the standard directory for
>> update modules is either /lib/modules/$VERSION/updates or
>> /lib/modules/$VERSION/extras.  We should follow that.
> 
> The script just call 'make install-modules' in the alsa-driver package. 
> Anyway, overwriting kernel modules is just a workaround to bypass the 
> standard packaging. I don't think that using a special directory helps.

I think it helps:

Building drivers from source I usually configure --with-moddir=updates/alsa

This means
* The newly generated modules do not overwrite the distro supplied ones.
 * I can easily revert to the distro ones by deleting updates/alsa (my
updates directory also has a dkms subdirectory) and rerunning depmod


--
Eliot
