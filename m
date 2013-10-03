From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-usx2y: fix start frame mask
Date: Thu, 3 Oct 2013 11:59:13 +0200
Message-ID: <CAEw7SVG-NK4Zjr5pvL2xusCDBD6-H1v1P-J9Q7rpbuQma+FiAA@mail.gmail.com>
References: <1380721197-4889-1-git-send-email-zonque@gmail.com>
 <s5hr4c3u6la.wl%tiwai@suse.de> <524C2485.2030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 73CC1265538
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 11:59:14 +0200 (CEST)
Received: by mail-ie0-f174.google.com with SMTP id u16so4773349iet.19
 for <alsa-devel@alsa-project.org>; Thu, 03 Oct 2013 02:59:13 -0700 (PDT)
In-Reply-To: <524C2485.2030301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I saw this thread only today.
if I remember well, that patch worked because the check wrapped around
03ff, but in the end I removed that check totally.
I haven't used my Tascam US122 since may 2013, because I work with an
RME Raydat in my studio and I used the Tascam only for live recording.
If you want, I can do some other testing on my US122.
Ciao
Guido Aulisi


2013/10/2 Daniel Mack <zonque@gmail.com>:
> On 02.10.2013 15:48, Takashi Iwai wrote:
>> At Wed,  2 Oct 2013 15:39:57 +0200,
>> Daniel Mack wrote:
>>>
>>> This patch is based on a change proposed by Guido Aulisi in a
>>> discussion on LAU which can be followed here:
>>>
>>>   http://linuxaudio.org/mailarchive/lau/2013/5/20/200177
>>>
>>> Cc: fzu@wemgehoertderstaat.de
>>> Original-code-by: Guido Aulisi <guido.aulisi@gmail.com>
>>> Tested-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>
>> Why this fixes the issue at all?
>> There is no explanation in the thread.
>
> I have no idea of this driver.
>
>> If any, the sanity check there is simply bogus for ehci, and it'd be
>> better to get rid of it completely.
>
> You're right. I guess, however, that there was a reason to add the code
> in the first place.
>
> Anyway, I'll send another patch that does the removal.
>
> Thanks,
> Daniel
>
