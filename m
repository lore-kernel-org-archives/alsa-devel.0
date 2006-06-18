From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Driver model ISA bus
Date: Sun, 18 Jun 2006 20:51:20 +0200
Message-ID: <4495A0A8.3080607__21829.9514301636$1150656685$gmane$org@keyaccess.nl>
References: <4485F97A.6020205@keyaccess.nl> <20060616234218.GC25127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F6CE142
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jun 2006 20:50:57 +0200 (MEST)
In-Reply-To: <20060616234218.GC25127@kroah.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Greg KH <greg@kroah.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Greg KH wrote:

> Sorry for the delay.  It looks great to me so I've added it to my
> tree and will push it upstream when I can.

Okay, lovely, thanks.

Takashi: I'll be converting ALSA ISA drivers over to this now. What I'd 
in fact would like to do is do that one driver at a time. I have a 
metric buttload of these old ISA soundcards and believe it would be a 
nice opportunity to actually test these old drivers (and possibly do 
some cleanups) as I go along. Would you mind that?

If you'd rather the isa_bus thing was one discrete change, that's also 
okay though. I'd then just do that as a somewhat mechanical change and 
then revisit those drivers at some later time for additional testing 
and/or cleanup.

In either case, I'll ofcourse not submit anything untill this thing has 
made -mm.

Rene.
