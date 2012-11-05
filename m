From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [FT C400,RFC 0/6] M-Audio Fast Track C400
Date: Mon, 5 Nov 2012 23:10:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211052249460.1181@xoschi>
References: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
 <CACckToWvY8_VgFMGFWSf+FhqcpXV4EbEft-hMd4nFBTea6Z-pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A50BD261651
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 23:11:07 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2073249bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 14:11:07 -0800 (PST)
In-Reply-To: <CACckToWvY8_VgFMGFWSf+FhqcpXV4EbEft-hMd4nFBTea6Z-pQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Chris Cavey <chris-alsa@rauros.net>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Grant,

On Mon, 5 Nov 2012, Grant Diffey wrote:

> 64samples/frame doesn't work for me ever
> 
> I'll build this patchset and test with an ftu tonight/tomorrow (yay for cup day holiday)

Sorry to break some bad news - I found out yesterday that I there's a
latency issue with this patchset. I noticed that while making some 
recordings with click. The problem was that the playback is in implicit 
feedback clocking, and the playback needs to sync to the capture EP.

The issue there is that the number of playback and capture channels is 
different, which means that the calculation of how many bytes to send is 
off by that factor. I fixed that (but I'm not sure it's the right way), 
and now the latency is stable - but not completely stable. And now playback
sounds distorted and I see that the real latency (measured with jack_delay
+ analog loopback) changes in -/+ 2 usecs range.
So it's not there quite yet, I'm afraid.

BTW, I got it to work with 1 jack client (jack_delay) for more than a 
couple of hours without an xrun (though latency was still going back 
and fort) with -r 96000 -p 128 -n 2, before I stopped it.

Anyway, I also noticed that the patchset didn't land on the mailing list 
because it's not an open list - sorry for that. 
I'll resend the patchset soon including what I mentioned above.

Happy holidays :)

Eldad
