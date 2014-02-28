From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Griffin FireWave stream format information
Date: Fri, 28 Feb 2014 22:51:23 +0900
Message-ID: <5310945B.90805@sakamocchi.jp>
References: <530EB782.6090205@sakamocchi.jp> <20140228105632.1a436d21@stein>
 <53106DCF.5050903@sakamocchi.jp> <20140228143454.3abb69fa@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 298DC265956
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 14:51:30 +0100 (CET)
In-Reply-To: <20140228143454.3abb69fa@stein>
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

(Feb 28 2014 22:34), Stefan Richter wrote:
 > stefan@stein ~ $ firewire-request /dev/fw8 fcp 
0x00ffbfc000000000ff0090400202010200
 > response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 
...........@....
 > response: 010: 00                                              .
 > stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
 > response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 
...........@....
 > response: 010: 00
 >...

OK. Now we get to know how to change modes from 5.1ch surround sound to 
'Dolby Pro Logic II' mode.

(Feb 28 2014 22:34), Stefan Richter wrote:
> Nope, it is only
>    0c ff bf c0 00 00 00 00 ff 00 90 40 0[2345] 02 01 02 00.

Yes. I made mistakes again. (I'm ashamed...)

 > To recover to 5.1ch surround, please execute this command:
 > (for 32.0kHz)
 > $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200
 > (for 44.1kHz)
 > $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200
 > (for 48.0kHz)
 > $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200
 > (for 96.0kHz)
 > $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400502010200

The last two bytes should be 0x0606.

Within this two bytes, the first byte means the number of data channels 
and the second byte means type of the data channel. So in FireWave, 6ch 
PCM data channel is expressed by 0x0606, 2ch IEC 60958-3 data channel is 
expressed by 0x0200.

I'm sorry to trouble you but I request you to try the sequence of 
commands with these fixes...


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
