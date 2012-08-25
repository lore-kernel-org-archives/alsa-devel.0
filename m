From: Daniel Mack <zonque@gmail.com>
Subject: Re: Logitech USB headset not working in 3.6-rc3
Date: Sat, 25 Aug 2012 14:02:51 +0200
Message-ID: <5038BEEB.6090303@gmail.com>
References: <20120824190808.GC20043@zod.bos.redhat.com>
 <5038007E.5060505@gmail.com> <20120825111749.GA17048@wolff.to>
 <20120825115423.GA14327@wolff.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D561B265D62
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2012 14:02:57 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so707029bkc.38
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2012 05:02:57 -0700 (PDT)
In-Reply-To: <20120825115423.GA14327@wolff.to>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bruno Wolff III <bruno@wolff.to>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 25.08.2012 13:54, Bruno Wolff III wrote:
> On Sat, Aug 25, 2012 at 06:17:49 -0500,
>    Bruno Wolff III <bruno@wolff.to> wrote:
>>
>> I see this behavior on three different computers. Rebooting into an old
>> enough kernel gets things working again. The older kernels also have 
>> older initramfs images. I could rebuild those to see if there is some 
>> issue there instead of the kernels themselves?
> 
> I tested one of the older kernels (where the headset still worked) with a 
> rebuilt initramfs and the headset still worked. So it likely isn't an issue 
> with something in the initramfs images.
> 

Can you revert commit e9ba389c5 ("ALSA: usb-audio: Fix
scheduling-while-atomic bug in PCM capture stream") and see if that
helps? If not, can you summarize again which kernels still work for you
and which don't?


Daniel
