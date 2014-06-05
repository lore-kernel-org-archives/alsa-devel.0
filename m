From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/2] ALSA: soundcore: coding style fixes
Date: Thu, 05 Jun 2014 16:14:11 +0200
Message-ID: <53907B33.1050402@zonque.org>
References: <1401970346-9043-1-git-send-email-zonque@gmail.com>	<s5hegz31mz0.wl%tiwai@suse.de>	<539077A7.1080007@zonque.org>
 <s5ha99r1m3u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F68E265626
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 16:14:13 +0200 (CEST)
In-Reply-To: <s5ha99r1m3u.wl%tiwai@suse.de>
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

On 06/05/2014 04:12 PM, Takashi Iwai wrote:
> At Thu, 05 Jun 2014 15:59:03 +0200,
> Daniel Mack wrote:
>>
>> On 06/05/2014 03:53 PM, Takashi Iwai wrote:
>>> At Thu,  5 Jun 2014 14:12:25 +0200,
>>> Daniel Mack wrote:
>>>>
>>>> sound/sounc_core.c has a larger number of style issues. Fix them to make the
>>>> code more readable. No functional change.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>
>>> Thanks for the patches, but are you going to fix anything in these
>>> codes along with them?  Such coding style fixes just stir git history,
>>> which make often annoying for backporting or reviewing.  So, basically
>>> I'd take such cleanup patches only if the real fixes will come
>>> together.
>>
>> Yeah, I know that code is legacy. I was just skimming over the sources
>> to trace a bug report on alsa-user, and stumbled over so many style
>> issues that made reading the code harder than necessary that I couldn't
>> resist fixing them :)
> 
> Ah, you're looking at usb disconnection issue?  I just saw the thread
> now...

Jup. I was hoping that I could reproduce it here, but failed. The I had
a quick look at the code, but I didn't find anything yet ...


Daniel
