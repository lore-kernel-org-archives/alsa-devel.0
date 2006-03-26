From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: bus_add_device() losing an error return from the probe() method
Date: Mon, 27 Mar 2006 00:30:19 +0200
Message-ID: <442715FB.7060404__7108.84490185908$1143412273$gmane$org@keyaccess.nl>
References: <44238489.8090402@keyaccess.nl> <20060325175322.1e04852b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 204B41E5
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 00:30:20 +0200 (MEST)
In-Reply-To: <20060325175322.1e04852b.akpm@osdl.org>
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
Cc: gregkh@suse.de, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Andrew Morton wrote:

> Looks sane, but please don't sprinkle `return' statements all over a 
> function in this manner.

I actually prefer the multiple returns. You then don't have to "visually 
scroll down" to the label to see what would happen when reading the 
code. Even when there's common code before the return, I've never seen 
GCC not optimise that to the goto form itself. You obviously the boss 
though.

> It's a little surprising that this function returns "OK" if bus==NULL.
> 
> Note that sysfs_create_link() can fail too.  This was one optimistic
> function.

I assume that Greg hasn't commented yet since he's busy rewriting it 
all, so that'll be okay :-)

Rene.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
