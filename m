From: Johannes Berg <johannes@sipsolutions.net>
Subject: delayed dma trigger
Date: Mon, 23 Oct 2006 10:49:51 +0200
Message-ID: <1161593391.6617.25.camel@ux156>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F000D187
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Oct 2006 10:48:52 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Benjamin Berg <benjamin@sipsolutions.net>, Paul Collins <paul@briny.ondioline.org>
List-Id: alsa-devel@alsa-project.org

Hi,

For AOA, there are some DMA engine programming pitfalls I wasn't aware
of previously (actually, I was aware of the bug it triggered but not
quite why it happened). But now we have two questions about the trigger
callback.

(1)
When correctly using the i2s bus (aoa isn't at the moment), it is not
possible to immediately stop doing DMA, the DMA engine has to finish the
current period first, then go into a stop condition, and only after that
we can stop the engine completely. Hence, this can take quite a while
(up to the period length). Is it ok to set the stop condition and return
from the trigger function without having DMA stopped? It'll be
completely stopped asynchronously on the next interrupt, and we'd have
to make the hw_free callback wait for that, I guess.

(2)
Relating to that, if a start trigger comes in before the DMA engine is
stopped, it would be nice if we could just clear the stop condition and
let it continue to run. Can recording start at any arbitrary period in
the buffer relying only on the pointer callback?
[Actually, come to think of it, isn't this required for proper 'pause'
function during playback or recording? I guess aoa is wrong now then?]

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
