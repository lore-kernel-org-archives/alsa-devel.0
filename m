From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Griffin FireWave stream format information
Date: Fri, 28 Feb 2014 10:56:32 +0100
Message-ID: <20140228105632.1a436d21@stein>
References: <530EB782.6090205@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id B94E9264FBA
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 10:56:35 +0100 (CET)
In-Reply-To: <530EB782.6090205@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Feb 27 Takashi Sakamoto wrote:
> Stefan or Jay,
> 
> Could I request you to get outputs against command in this message with
> FireWave?

Jay already responded, but 

[...]
> Based on this guess and according to its manual, FireWave should have 7
> entries:
> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff01ff
> 0c ff bf c1 00 00 00 00 ff 00 01 90 40 02 02 01 06 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff01ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 01 90 40 02 02 01 ............@...
response: 010: 06 06                                           ..

> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff02ff
> 0c ff bf c1 00 00 00 00 ff 00 02 90 40 03 02 01 06 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff02ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 02 90 40 03 02 01 ............@...
response: 010: 06 06                                           ..

> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff03ff
> 0c ff bf c1 00 00 00 00 ff 00 03 90 40 04 02 01 06 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff03ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 03 90 40 05 02 01 ............@...
response: 010: 06 06                                           ..

> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff04ff
> 0c ff bf c1 00 00 00 00 ff 00 04 90 40 05 02 01 06 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff04ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 04 90 40 02 02 01 ............@...
response: 010: 02 00                                           ..

> (These four is for 6ch sound for usual 5.1ch surround)
> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff05ff
> 0c ff bf c1 00 00 00 00 ff 00 05 90 40 02 02 01 02 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff05ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 05 90 40 03 02 01 ............@...
response: 010: 02 00                                           ..

> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff06ff
> 0c ff bf c1 00 00 00 00 ff 00 06 90 40 03 02 01 02 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff06ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 06 90 40 04 02 01 ............@...
response: 010: 02 00                                           ..

> $ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff07ff
> 0c ff bf c1 00 00 00 00 ff 00 07 90 40 04 02 01 02 06

$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff07ff
response: 000: 0a ff bf c1 00 00 00 00 ff ff 07 ff             ............

> (These three is for 2ch stereo sound for Dolby Pro Logic II)
> 
> Would you please confirm these output?

So this seems to be the same as from Jay's FireWave specimen.
Here are results of the other requests from your subsequent mail:

$ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 06 ...........@....
response: 010: 06                                              .

$ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400202010200
response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
response: 010: 00                                              .

$ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400302010200
response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
response: 010: 00                                              .

$ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400402010200
response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 00                                              .

-- 
Stefan Richter
-=====-====- --=- ===--
http://arcgraph.de/sr/
