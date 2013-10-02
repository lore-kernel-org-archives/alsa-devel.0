From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-usx2y: remove bogus frame
	check
Date: Wed, 02 Oct 2013 17:49:29 +0200
Message-ID: <524C4089.4070704@gmail.com>
References: <1380722068-6885-1-git-send-email-zonque@gmail.com>
 <s5ha9iru1a3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f172.google.com (mail-ea0-f172.google.com
 [209.85.215.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B9D426509E
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 17:49:36 +0200 (CEST)
Received: by mail-ea0-f172.google.com with SMTP id r16so501308ead.3
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 08:49:36 -0700 (PDT)
In-Reply-To: <s5ha9iru1a3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, guido.aulisi@gmail.com, nicholas.bailey@glasgow.ac.uk
List-Id: alsa-devel@alsa-project.org

On 02.10.2013 17:43, Takashi Iwai wrote:
> At Wed,  2 Oct 2013 15:54:28 +0200,
> Daniel Mack wrote:
>>
>> The frame check in i_usX2Y_urb_complete() is bogus and produces false
>> positives as described in this LAU thread:
>>
>>   http://linuxaudio.org/mailarchive/lau/2013/5/20/200177
>>
>> This code removes the check code entirely.
>>
>> Cc: fzu@wemgehoertderstaat.de
>> Reported-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> It's referred in usx2yhwdeppcm.c, too (the file is included there).

Eek. I missed that. Thanks for the heads-up.

> Yeah, I know that the driver code is fairly complex (IOW ugly).  IIRC,
> the hwdeppcm mmap is also broken, and we need yet another fix.
> Sigh...

I don't know if Karsten (cc) is still maintaning this piece of code :-/


Daniel
