From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [PATCH] Fix ALSA resume
Date: Sat, 04 Dec 2004 19:39:28 -0800
Message-ID: <41B282F0.3020704@triplehelix.org>
References: <1102195391.1560.65.camel@tux.rsn.bth.se> <20041204172855.350100d0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041204172855.350100d0.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, torvalds@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrew Morton wrote:
> But Joshua crosses his heart and swears that the pci_disable_device() is
> also needed for a successful swsusp resume.

I never said I had any problems with resuming.

That said, I tried removing the pci_disable_device call and things seem
to still work. So I guess it can be left out?

-- 
Joshua Kwan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
