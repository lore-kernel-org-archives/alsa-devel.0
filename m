From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: Fix double locking of card list in
 snd_card_register()
Date: Thu, 4 Jun 2009 00:21:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906040018100.4067@eeebox2.perex-int.cz>
References: <1244058209-18851-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhbyxvw3x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2424C1038C3
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 00:21:52 +0200 (CEST)
In-Reply-To: <s5hhbyxvw3x.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Jun 2009, Takashi Iwai wrote:

> At Wed,  3 Jun 2009 20:43:29 +0100,
> Mark Brown wrote:
>>
>> The introduction of snd_card_set_id() added a lock on the card list
>> to the old choose_default_id() function when using it to implement
>> the new API call. This lock is needed to allow us to walk the list
>> and check to see if our new name is a duplicate. Unfortunately this
>> causes a lockup when called from snd_card_register() (in cases
>> where no ID is supplied for the card) since the card list is already
>> locked there.
>
> Oh, thanks for catching this.  Obviously I haven't tested the
> latest code enough...

Yes, thanks.

>> Fix this fairly hideously by factoring out the implementation and
>> using a flag to indicate if the lock should be held. A better fix
>> would probably be to refactor snd_card_register() to move the
>> _set_id() outside the locking region but I can't immediately see
>> anything I can convince myself is safe.
>
> Agreed, there can be a cleaner solution but your fix is definitely
> safe.  So I applied it as a quick fix.

The patch has a unlock problem in 'if (snd_cards[i] && 
!strcmp(snd_cards[i]->id, id)) {' block.

Anyway, here is next cleanup which will remove locking outside the 
internal id function and fixes also next possible race in unique id 
allocation:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=13d55b5cb27a3c35d0fb2a48e1ee10ec89488569

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
