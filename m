From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: handling rate change on digital inputs?
Date: Tue, 30 May 2006 16:07:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605301559330.9178@tm8103.perex-int.cz>
References: <1148997314.4372.16.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0745E14E
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 16:07:53 +0200 (MEST)
In-Reply-To: <1148997314.4372.16.camel@johannes>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 May 2006, Johannes Berg wrote:

> Hey,
> 
> While thinking about how I can support the optical input on Apple
> machines, I came to the following question:
> 
> What should I do if, while some app is recording, the input rate on the
> digital connector changes?
> If it changes before the app starts recording, I can tell the app
> during .open what rate I have, but while it is recording? Can I (and
> should I) kick out the application?

Yes, the stream must go to the DRAINING state immediately when rate (or 
other parameter) does not match (it's good to check this condition in the 
interrupt handler) and trigger() callback must return -EIO in this case 
when stream is requested to come up (START, PAUSE_RELEASE or RESUME).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
