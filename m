From: Kailang <kailang@realtek.com>
Subject: Re: Remove fixup list for HP
Date: Mon, 2 Dec 2013 17:37:38 +0800
Message-ID: <E68F3069D7344EF98DB5285080E12B0A@realtek.com.tw>
References: <518AFC8C447A490197E89F86A38FA213@realtek.com.tw>
 <s5hy5438upr.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C9A86262600
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:37:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I add the model in next patch.
You could see in Independent of model for HP.

Thanks.
Kailang

> At Mon, 2 Dec 2013 17:20:37 +0800,
> Kailang wrote:
>> 
>> Hi Takashi,
>> 
>> Chrome OS was loaded driver by models.
>> The patch was remove the alc269 fixup entry for HP chrome book.
> 
> If the driver still works with this patch on Chrome, I'd be very
> surprised.  There is no place allowing to hook this with model entry.
> 
> In other words, please give a proper patch that *adds* the entry for
> the model option, too.  Currently it just removes the entry and
> regresses.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
