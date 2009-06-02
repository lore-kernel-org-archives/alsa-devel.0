From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give
	better	shortname
Date: Tue, 2 Jun 2009 12:28:34 +0200
Message-ID: <20090602102834.GF26160@buzzloop.caiaq.de>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
	<1243884987-20256-1-git-send-email-daniel@caiaq.de>
	<1243884987-20256-2-git-send-email-daniel@caiaq.de>
	<alpine.LNX.2.00.0906012306460.4067@eeebox2.perex-int.cz>
	<s5hmy8rms9j.wl%tiwai@suse.de>
	<20090602072948.GO26148@buzzloop.caiaq.de>
	<s5hfxejrs6k.wl%tiwai@suse.de>
	<20090602093104.GC26160@buzzloop.caiaq.de>
	<s5htz2zt15j.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0906021210580.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A35E2103835
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 12:28:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906021210580.4067@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 12:11:33PM +0200, Jaroslav Kysela wrote:
>> Looks almost good, but we need to check
>> snd_info_check_reserved_words() too.
>>
>> I guess the routine in choose_default_id() can be reused for this
>> function, though.
>>
>> Jaroslav seems working on this now, so maybe he could better cope
>> with you...
>
> Daniel, could you test this patch?
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=5384d153538ef403c5ca51a6e0c8b85b735c877a

Yep - same behaviour than with my patch. Let's take your's :)

Thanks,
Daniel
