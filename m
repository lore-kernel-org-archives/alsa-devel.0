From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-usx2y: fix start frame mask
Date: Wed, 02 Oct 2013 15:49:57 +0200
Message-ID: <524C2485.2030301@gmail.com>
References: <1380721197-4889-1-git-send-email-zonque@gmail.com>
 <s5hr4c3u6la.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACB62652B7
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 15:50:49 +0200 (CEST)
Received: by mail-ea0-f169.google.com with SMTP id k11so417211eaj.28
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 06:50:49 -0700 (PDT)
In-Reply-To: <s5hr4c3u6la.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, guido.aulisi@gmail.com
List-Id: alsa-devel@alsa-project.org

On 02.10.2013 15:48, Takashi Iwai wrote:
> At Wed,  2 Oct 2013 15:39:57 +0200,
> Daniel Mack wrote:
>>
>> This patch is based on a change proposed by Guido Aulisi in a
>> discussion on LAU which can be followed here:
>>
>>   http://linuxaudio.org/mailarchive/lau/2013/5/20/200177
>>
>> Cc: fzu@wemgehoertderstaat.de
>> Original-code-by: Guido Aulisi <guido.aulisi@gmail.com>
>> Tested-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Why this fixes the issue at all?
> There is no explanation in the thread.

I have no idea of this driver.

> If any, the sanity check there is simply bogus for ehci, and it'd be
> better to get rid of it completely.

You're right. I guess, however, that there was a reason to add the code
in the first place.

Anyway, I'll send another patch that does the removal.

Thanks,
Daniel
