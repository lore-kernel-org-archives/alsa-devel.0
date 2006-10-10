From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: provide a device name list for applications
Date: Tue, 10 Oct 2006 20:40:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610102034150.9410@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610101530410.9410@tm8103.perex-int.cz>
	<s5hodskm8t7.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610101948490.9410@tm8103.perex-int.cz>
	<s5h3b9wm4d6.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610102008420.9410@tm8103.perex-int.cz>
	<s5hvemskp71.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610102021110.9410@tm8103.perex-int.cz>
	<s5hr6xgkomq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C648161
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Oct 2006 20:40:25 +0200 (MEST)
In-Reply-To: <s5hr6xgkomq.wl%tiwai@suse.de>
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

On Tue, 10 Oct 2006, Takashi Iwai wrote:

> A merit of export tag is that it requires a description to be listed.
> Listing all devices means that many devices are listed without
> descriptions, and this situation should be avoided from usability
> POV.

I would keep description as description and list tag as list tag. We can 
use the description also for different purpose in future and looking to 
two keys for one thing does not sound ideal to me.

The question is only what should be the default value for the list tag.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
