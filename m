From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Tascam FW-1884 driver
Date: Sat, 20 Oct 2018 20:22:32 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1810201957090.7585@laptop>
References: <AM0PR0302MB33488540134419EAEDE0B317A4FA0@AM0PR0302MB3348.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-328419625-1540034559=:7585"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by alsa0.perex.cz (Postfix) with ESMTP id AB5D52675A4
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2018 13:22:40 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id w5-v6so39953468wrt.2
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2018 04:22:40 -0700 (PDT)
In-Reply-To: <AM0PR0302MB33488540134419EAEDE0B317A4FA0@AM0PR0302MB3348.eurprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-15?Q?C=E9dric_Mialaret?= <cedric@mialaret.com>
Cc: alsa-devel@alsa-project.org, sbahling@suse.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-328419625-1540034559=:7585
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,
(C.C.ed to alsa-devel, ffado-devel and Scott)

On Sat, 20 Oct 2018, Cédric Mialaret wrote:
> I stumbled up the source code of a linux driver for the Tascam FW-1884 audio interface:
> 
> https://elixir.bootlin.com/linux/v4.19-rc8/source/sound/firewire/tascam/tascam.c
>
>  a. Does it work ?

It, ALSA firewire-tascam driver, works for systems in which Linux kernel 
is used. It's already included in Linux kernel source since kernel v4.4.

>  b. Does it implement all functionalities of the FW-1884 ?

As of kernel v4.19, it supports below functionalities:
  - data transmission for PCM frames via ALSA PCM interface
  - data transmission for MIDI messages via ALSA rawmidi interface

Recently I got Scott's help and work to support handling control 
messages from faders/knobs/buttons on control surface of FW-1884/FW-1082. You can 
see recent patches in my remote repository:
  - 
https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-take3
  - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace-take3

You can see our discussion in list:
  - 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-October/140593.html

>  c. Is this the original code from Tascam/Frontier Design?

Apparently, no. It comes from my work for reverse engineering, by sniffing 
packet communications over IEEE 1394 bus.

>  d. Do you by any chance have the source code of the Windows driver ?

I have no such chance, as well as the others.


Regards

Takashi Sakamoto
--8323329-328419625-1540034559=:7585
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-328419625-1540034559=:7585--
