From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: snd_usb_caiaq: give
	better	shortname
Date: Sat, 30 May 2009 23:36:26 +0200
Message-ID: <20090530213626.GI26148@buzzloop.caiaq.de>
References: <1243715123-16414-1-git-send-email-daniel@caiaq.de>
	<1243715123-16414-2-git-send-email-daniel@caiaq.de>
	<alpine.LNX.2.00.0905302306110.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 371D3243B4
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 23:36:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905302306110.4067@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, May 30, 2009 at 11:17:08PM +0200, Jaroslav Kysela wrote:
>> ALSA's core will only take the last part of a string from the shortname,
>> hence replace all ' ' by '_'. For example, the card name 'Audio 4 DJ'
>> was shortened to 'DJ' before which doesn't look nice at all.
>>
>> Signed-off-by: Daniel Mack <daniel@caiaq.de>
>
> NAK. It would be better to improve the core function choose_default_id()  
> rather than doing this ugly character mangling in the lowlevel driver or  
> add a function to set ID (card->id) from the lowlevel driver.

Oh yes, you're right. I now realized all I need to do is fill card->id
with something sane, so choose_default_id() won't get called at all.

I'll resend the whole set.

Thanks,
Daniel
