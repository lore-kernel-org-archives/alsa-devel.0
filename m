From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 02 Aug 2010 11:30:56 +0100
Message-ID: <1280745056.3095.46.camel@odin>
References: <1280742830.3095.33.camel@odin>  <s5hpqy1nx00.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF7624480
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 12:31:00 +0200 (CEST)
Received: by wwe15 with SMTP id 15so2341432wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 03:31:00 -0700 (PDT)
In-Reply-To: <s5hpqy1nx00.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-02 at 12:13 +0200, Takashi Iwai wrote:
> At Mon, 02 Aug 2010 10:53:50 +0100,
> Liam Girdwood wrote:
> 
> > Btw, when are you thinking of doing a pull
> > request for 2.6.36 ? I'm doing a multi-component patch series later
> > today and if all goes well it would be nice to get it in for the 2.6.36
> > merge window.
> 
> I thought to send a pull request in the middle of this week, depending
> on the pending bugs / features.  So I'm still open for new stuff for a
> few days.  As long as it's local to ASoC, I'm fine to merge it now.
> 

Ok, the multi-component branch does touch arch quite a bit as we are
adding platform devices for all our components. So it's probably safer
for merging (after your pull request) in the for 2.6.37 period to reduce
any merge conflict with arch.

Fwiw, the release yesterday did take me a little by surprise as I was at
least expecting an rc7 and a little extra time for multi-comp ;)

Thanks

Liam 
