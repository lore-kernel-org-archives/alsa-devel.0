From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Griffin FireWave stream format information
Date: Fri, 28 Feb 2014 23:39:08 +0900
Message-ID: <53109F8C.4030703@sakamocchi.jp>
References: <530EB782.6090205@sakamocchi.jp> <20140228105632.1a436d21@stein>
 <53106DCF.5050903@sakamocchi.jp> <20140228143454.3abb69fa@stein>
 <5310945B.90805@sakamocchi.jp> <20140228150916.07416202@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9849126510C
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:39:16 +0100 (CET)
In-Reply-To: <20140228150916.07416202@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Stefan,

> $ for n in 2 3 4 5; do echo $n; firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400${n}02010606; sleep 1; firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff; sleep 1; done
> 2
> response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 06 ...........@....
> response: 010: 06                                              .
> response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 06 ...........@....
> response: 010: 06                                              .
> 3
> response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 06 ...........@....
> response: 010: 06                                              .
> response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 06 ...........@....
> response: 010: 06                                              .
> 4
> response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 06 ...........@....
> response: 010: 06                                              .
> response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 06 ...........@....
> response: 010: 06                                              .
> 5
> response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 05 02 01 06 ...........@....
> response: 010: 06                                              .
> response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 05 02 01 06 ...........@....
> response: 010: 06                                              .

Thanks. Now we get to know the way to recover from '2ch IEC 60958-3 
data' mode to '6ch PCM data' mode.

I note that this 'SINGLE' sunfunction of 'AV/C Stream Format 
Information' command can also be used to switch sampling rate instead of 
'AV/C PLUG SIGNAL FORMAT' command (i.e. 0x00ff18009002ffff).


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
