From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Tue, 14 Oct 2008 12:13:15 +0400
Message-ID: <20081014121315.7547dd5c.baz@irc.msk.ru>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5hod1pz1xl.wl%tiwai@suse.de>
	<20081013165805.735bf06e.baz@irc.msk.ru>
	<s5htzbg63bq.wl%tiwai@suse.de> <48F35C4C.40307@gmail.com>
	<s5hej2k5ysj.wl%tiwai@suse.de> <s5hbpxo5wmw.wl%tiwai@suse.de>
	<s5h1vyk5vr3.wl%tiwai@suse.de> <s5hy70s4h0i.wl%tiwai@suse.de>
	<20081013232147.026f38c9.baz@irc.msk.ru>
	<s5hzll7oetb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 17A92243AD
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 10:13:49 +0200 (CEST)
In-Reply-To: <s5hzll7oetb.wl%tiwai@suse.de>
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

On Tue, 14 Oct 2008 08:45:20 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 13 Oct 2008 23:21:47 +0400,
> Alexey Bazhin wrote:
> > 
> > Now it doesn't hangs :)
> 
> Glad to hear.  Did you have to use XXX_SYSTEM_TIMER or any workaround
> needed?  Or, did it work as is?
No, i didn't used XXX_SYSTEM_TIMER
 
> > but speakers-test produces crackling sine and
> > fails on test...
> 
> Do you mean it aborts some time later after starting the stream?
Yes

> Could you show the kernel messages?  The default debug level should
> suffice, I guess.  If any, try debug=2.

> How about the patch below for 48kHz?

I'll test it later (my test box freezed again...)

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
