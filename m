From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give
	better	shortname
Date: Tue, 2 Jun 2009 11:55:25 +0200
Message-ID: <20090602095525.GD26160@buzzloop.caiaq.de>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
	<1243884987-20256-1-git-send-email-daniel@caiaq.de>
	<1243884987-20256-2-git-send-email-daniel@caiaq.de>
	<alpine.LNX.2.00.0906012306460.4067@eeebox2.perex-int.cz>
	<s5hmy8rms9j.wl%tiwai@suse.de>
	<20090602072948.GO26148@buzzloop.caiaq.de>
	<s5hfxejrs6k.wl%tiwai@suse.de>
	<20090602093104.GC26160@buzzloop.caiaq.de>
	<s5htz2zt15j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5436924501
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 11:55:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htz2zt15j.wl%tiwai@suse.de>
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

On Tue, Jun 02, 2009 at 11:50:32AM +0200, Takashi Iwai wrote:
> > What about that patch below? Works well in my tests here.
> 
> Looks almost good, but we need to check
> snd_info_check_reserved_words() too.

Ok.

> I guess the routine in choose_default_id() can be reused for this
> function, though.

Yes, choose_default_id() could be split up into some static functions
which could then be used by my snd_card_make_id_unique() as well.

Daniel
