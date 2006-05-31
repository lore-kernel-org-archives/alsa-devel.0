From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: handling rate change on digital inputs?
Date: Wed, 31 May 2006 12:43:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605311241550.9226@tm8103.perex-int.cz>
References: <1148997314.4372.16.camel@johannes>
	<Pine.LNX.4.61.0605301559330.9178@tm8103.perex-int.cz>
	<1148998283.4372.18.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05D0E14E
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 12:43:20 +0200 (MEST)
In-Reply-To: <1148998283.4372.18.camel@johannes>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 30 May 2006, Johannes Berg wrote:

> On Tue, 2006-05-30 at 16:07 +0200, Jaroslav Kysela wrote:
> 
> > Yes, the stream must go to the DRAINING state immediately when rate (or 
> > other parameter) does not match (it's good to check this condition in the 
> > interrupt handler) and trigger() callback must return -EIO in this case 
> > when stream is requested to come up (START, PAUSE_RELEASE or RESUME).
> 
> Do you know if there's any sample code for this somewhere? Or if any
> drivers implement this properly?

Check pdaudiocf_pcm.c and i2c/other/ak4117.c.

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
