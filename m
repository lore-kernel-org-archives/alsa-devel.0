From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: Re: another device for opl3sa2
Date: Mon, 9 Jul 2007 11:14:17 -0700
Message-ID: <20070709181417.GA20169@math.berkeley.edu>
References: <20070703002739.GA27389@math.berkeley.edu>
	<s5hfy45ajk1.wl%tiwai@suse.de>
	<20070704022423.GA2012@math.berkeley.edu>
	<s5h4pkka6tq.wl%tiwai@suse.de>
	<20070705080302.GA6818@math.berkeley.edu>
	<s5hk5te6hku.wl%tiwai@suse.de>
	<20070706074136.GA4460@math.berkeley.edu>
	<s5hy7ht50ir.wl%tiwai@suse.de>
	<20070708080224.GA14178@math.berkeley.edu>
	<s5hwsx9u4sk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.Math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 54B601038B0
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 20:14:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwsx9u4sk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 09, 2007 at 02:42:35PM +0200, Takashi Iwai wrote:

> Hmm, if I understand correctly from your debug messages, I don't see
> significant differences between opl3sa2 and cs4232 cases.

Well, with opl3sa2, it never reaches the end of mce_down

> Just to be sure, both first and second aplay on opl3sa2 didn't work
> (no sound output) while cs4232 was OK, right?

No, only the first aplay on opl3sa2 produced no output.  The second one
worked fine.

--Paul Vojta
