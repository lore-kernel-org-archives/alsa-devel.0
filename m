From: Mattia Bertoni <mattia.b89@gmail.com>
Subject: Re: bug
Date: Thu, 08 Aug 2013 11:55:50 +0200
Message-ID: <52036B26.10906@gmail.com>
References: <520268D8.3000807@gmail.com> <52028080.4090608@gmail.com>
 <s5hk3jwa75k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 161E32619D0
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 11:55:56 +0200 (CEST)
Received: by mail-wi0-f176.google.com with SMTP id f14so363057wiw.9
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2013 02:55:55 -0700 (PDT)
In-Reply-To: <s5hk3jwa75k.wl%tiwai@suse.de>
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

fortunately I have had this problem only once and more than one month 
ago (15 Jun)
but unfortunately I can't reproduce it because it appeared casually

I'm not a newbie and I knowthis is not the right way to report an issue, 
but these are the all and only information that I have;
anyway other important info are (with the hope you can fix this issue):

Asus A8N-E with nForce4 ultra - CK804 AC'97 Audio Controller (rev a2)
Realtek ALC850 rev 0 at irq 20
snd_intel8x0


archlinux x86_64
kernel3.9.5-1
alsa 1.0.27.1-2
pulseaudio 4.0-2
jack2 1.9.9.5-3

finally I uploaded the output of alsa-info.sh
BUT because I can't reproduce the bug I don't know if this is useful, 
also because it's the output of today in which software is newer:

http://pastebin.com/5SsiVh2u





On 08/08/13 11:00, Takashi Iwai wrote:
> At Wed, 07 Aug 2013 19:14:40 +0200,
> Mattia Bertoni wrote:
>> finally I can report a bug which I encountered some time ago; I send you
>> the important part of the entire log, which is to much big to be posted:
> You didn't write what's your problem at all, so no one understands
> what to do with it.
>
> In addition, the fundamental information is missing: which machine,
> which distro, which kernel and sound systems, and how to reproduce the
> problem.  The first few items can be covered by providing the
> alsa-info.sh output taken from your machine (at best take it after the
> problem appears).
>
>
> thanks,
>
> Takashi
