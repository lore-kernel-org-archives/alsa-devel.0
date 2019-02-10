From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Driver for MOTU devices
Date: Sun, 10 Feb 2019 12:07:32 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1902101202270.16829@laptop>
References: <CAKA+30RDiFjzxJBOA0qZ-Kf_RcYyRJosrEeB89AzrNSPtjTgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2008205354-1549768068=:16829"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C876267503
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2019 04:07:50 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id m1so3347824pgq.8
 for <alsa-devel@alsa-project.org>; Sat, 09 Feb 2019 19:07:50 -0800 (PST)
In-Reply-To: <CAKA+30RDiFjzxJBOA0qZ-Kf_RcYyRJosrEeB89AzrNSPtjTgcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-15?Q?Peter_Sj=F6berg?= <autopeter@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2008205354-1549768068=:16829
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Feb 2019, Peter Sjöberg wrote:
> Hello!
> 
> I'm contacting you as the developer of the kernel driver for MOTU firewire devices.
> 
> First I want to thank you for your time and effort to develop the driver - I have the Audio Express which was unusable in Linux for a long time so this was a
> really nice surprise!
> 
> I want to ask you a question about the code, if it's the wrong place to ask please redirect me. 
> In the file amdtp-motu.c line 139 the code thas converts 24 to 32 bits reads:
>    *dst = (byte[0] << 24) | (byte[1] << 16) | byte[2];
> ..however I am puzzled by the conversion of the third byte here. In my mind it should be:
>    *dst = (byte[0] << 24) | (byte[1] << 16) | (byte[2] << 8);
> 
> The conversion in the other direction is written like this (line 167-169):
>   byte[0] = (*src >> 24) & 0xff;
>   byte[1] = (*src >> 16) & 0xff;
>   byte[2] = (*src >> 8) & 0xff;
>  
> I just want to help out so please inform me if I'm wrong and why :)

Oops. It's a bug since v4.12 or later, indeed.

Unfortunately, I'm on vacation. I'll post the patch to fix it in next week
after testing it with MOTU models I own. Thanks for your report ;)


By the way, I guess that you see many kernel messages with 'unsolicited 
response' from firewire-core driver, like.

fireire_core 0000:03:00.0: unsolicited response (source ffc0, tlabel 1f)

As long as I know, AudioExpress often transfers invalid response code for
any asynchronous transaction[1]. This brings failures of read/write 
transaction and ALSA MOTU driver sometimes fails to handle the device.

For your information.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/motu?id=3a93d082bacf887b47737c4b75c083dea7570832

Regards


Takashi Sakamoto


--8323329-2008205354-1549768068=:16829
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-2008205354-1549768068=:16829--
