From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: minimalistic TLV implementation
Date: Thu, 1 Jun 2006 17:16:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606011715050.9144@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0605311500480.9226@tm8103.perex-int.cz>
	<s5hzmgx6rtb.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011510010.9144@tm8103.perex-int.cz>
	<s5hpsht6lo6.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011602020.9144@tm8103.perex-int.cz>
	<s5hirnl6isc.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011645530.9144@tm8103.perex-int.cz>
	<s5hejy87vu4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A064915A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 17:16:14 +0200 (MEST)
In-Reply-To: <s5hejy87vu4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Jun 2006, Takashi Iwai wrote:

> Well, but this ioctl is damn simple.  Just query a control element for
> its TLV data.
> 
> It's supposed to be the one containing all.  If we need a filter of
> returned data, the query header should contain a type field rather
> than flags.

Sure, but this ioctl can handle global data (not numid dependant) as well. 
If we decide to have two ioctls then it's also ok to me.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
