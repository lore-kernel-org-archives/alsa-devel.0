From: Domen Puncer <domen@coderock.org>
Subject: Re: [patch 1/1] sound/emu8000: replace schedule_timeout() with msleep()
Date: Wed, 9 Mar 2005 09:09:35 +0100
Message-ID: <20050309080935.GA10041@nd47.coderock.org>
References: <20050305153703.CE9AE1EE1E@trashy.coderock.org> <s5hmzte167q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E16F1AC
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 09:09:41 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hmzte167q.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, nacc@us.ibm.com
List-Id: alsa-devel@alsa-project.org

On 08/03/05 16:56 +0100, Takashi Iwai wrote:
> At Sat, 05 Mar 2005 16:37:03 +0100,
> domen@coderock.org wrote:
> > 
> > 
> > Use ssleep() instead of schedule_timeout() to guarantee the task
> > delays as expected. The current code uses TASK_INTERRUPTIBLE, but does not check
> > for signals / early return, so ssleep() should be appropriate. I am fairly
> > certain the time conversion is ok, as well.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> This was already in ALSA tree (i.e. mm tree should include it).

A bit different, so it confuzed scripts :-)

Thanks, Takashi.

> 
> 
> Takashi


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
