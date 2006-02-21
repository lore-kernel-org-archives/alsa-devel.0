From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp cards)
 broken in 2.6.16-rc4
Date: Tue, 21 Feb 2006 20:35:38 +0100
Message-ID: <43FB6B8A.6070904__8877.68986071951$1140550606$gmane$org@keyaccess.nl>
References: <43F9F9F2.4070203@keyaccess.nl>	<s5hu0askd7e.wl%tiwai@suse.de>	<43FB3718.6060503@keyaccess.nl> <s5hek1wk3op.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 69DCE15C
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 20:35:22 +0100 (MET)
In-Reply-To: <s5hek1wk3op.wl%tiwai@suse.de>
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
Cc: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Rene Herman wrote:

>> "ALSA sound/core/device.c:106: device free eee4e000 (from f099153d), not 
>> found"

> This is harmless.  The opl3-oss instance was already freed but the
> driver tries to release it again just to be sure.
> 
> The patch below should fix this annoyance.

Ah, good. Yes, it ofcourse does. Thanks. So, only the isapnp/bustype one 
was in fact a problem, it seems...

Rene.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
