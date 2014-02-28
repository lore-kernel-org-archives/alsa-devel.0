From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Griffin FireWave stream format information
Date: Fri, 28 Feb 2014 20:06:55 +0900
Message-ID: <53106DCF.5050903@sakamocchi.jp>
References: <530EB782.6090205@sakamocchi.jp> <20140228105632.1a436d21@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE76261A27
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 12:07:03 +0100 (CET)
In-Reply-To: <20140228105632.1a436d21@stein>
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

Hi Stefan,

Thanks for your report.

(Feb 28 2014 18:56), Stefan Richter wrote:
> $ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400202010200
> response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
> response: 010: 00                                              .
>
> $ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400302010200
> response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
> response: 010: 00                                              .
>
> $ firewire-request /dev/fw8 fcp 0x00ffbfc100000000ff0090400402010200
> response: 000: 08 ff bf c1 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
> response: 010: 00                                              .

Oh, I made a mistake again...

The subfunction should be 0xc0 (Single) instead of 0xc1 (List). 'Extend 
Stream Format Information' command don't allow ctype=control for List 
subfunction.

These are correct commands:
(for 32.0kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200
(for 44.1kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200
(for 48.0kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200

If one of them are accepted, the stream format is changed for 2ch IEC 
60958-3 at indicated rate. To confirm it, please execute this command again:
$ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
Response should be:
0c ff bf c0 00 00 00 00 ff 00 90 40 0[234] 02 01 02 00

To recover to 5.1ch surround, please execute this command:
(for 32.0kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200
(for 44.1kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200
(for 48.0kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200
(for 96.0kHz)
$ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400502010200

To confirm it, please execute this command again:
$ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff

Response should be:
0c ff bf c0 00 00 00 00 ff 00 90 40 0[2345] 02 01 06 06


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
