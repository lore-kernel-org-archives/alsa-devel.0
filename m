From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 13/20] sound/gus_pcm: remove interruptible_sleep_on_timeout() usage
Date: Fri, 4 Feb 2005 09:02:40 -0800
Message-ID: <20050204170240.GA2571__12662.1468378746$1107536671$gmane$org@us.ibm.com>
References: <20050202195013.GR2546@us.ibm.com> <s5h4qgsz6fj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E67851ED
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 18:02:45 +0100 (MET)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j14H2hCO519194
	for <alsa-devel@alsa-project.org>; Fri, 4 Feb 2005 12:02:44 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j14H2gBC308718
	for <alsa-devel@alsa-project.org>; Fri, 4 Feb 2005 10:02:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j14H2gD4010511
	for <alsa-devel@alsa-project.org>; Fri, 4 Feb 2005 10:02:42 -0700
Content-Disposition: inline
In-Reply-To: <s5h4qgsz6fj.wl@alsa2.suse.de>
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
Cc: perex@suse.cz, alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 04, 2005 at 04:33:04PM +0100, Takashi Iwai wrote:
> At Wed, 2 Feb 2005 11:50:13 -0800,
> Nishanth Aravamudan wrote:
> > 
> > Hello,
> > 
> > Please consider applying.
> > 
> > Description: Replace deprecated interruptible_sleep_on_timeout() with
> > wait_event_timeout(). Code is not identical, as the current sleeping system is 1
> > jiffy at a time checking atomic_read()'s return every iteration. Patch is
> > compile-tested.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> Thanks, I applied this one.
> 
> The other fixes for sound/seq/* stuff are not applied.  Instead, I
> modified the code to use wait_event*() properly.
> Now all sleep_on*() are gone from ALSA tree.

Great! Thanks for all your help, Takashi!

-Nish


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
