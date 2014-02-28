From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Griffin FireWave stream format information
Date: Fri, 28 Feb 2014 14:34:54 +0100
Message-ID: <20140228143454.3abb69fa@stein>
References: <530EB782.6090205@sakamocchi.jp> <20140228105632.1a436d21@stein>
 <53106DCF.5050903@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 8627B265141
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 14:34:56 +0100 (CET)
In-Reply-To: <53106DCF.5050903@sakamocchi.jp>
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

On Feb 28 Takashi Sakamoto wrote:
> These are correct commands:
> (for 32.0kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
response: 010: 00                                              .

> (for 44.1kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
response: 010: 00                                              .

> (for 48.0kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 00                                              .

> If one of them are accepted, the stream format is changed for 2ch IEC 
> 60958-3 at indicated rate. To confirm it, please execute this command again:
> $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
> Response should be:
> 0c ff bf c0 00 00 00 00 ff 00 90 40 0[234] 02 01 02 00

Yep, it is
  0c ff bf c0 00 00 00 00 ff 00 90 40 0[234] 02 01 02 00.

> To recover to 5.1ch surround, please execute this command:
> (for 32.0kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400202010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 02 02 01 02 ...........@....
response: 010: 00                                              .

> (for 44.1kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400302010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 03 02 01 02 ...........@....
response: 010: 00                                              .

> (for 48.0kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400402010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 00                                              .

> (for 96.0kHz)
> $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400502010200

stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x00ffbfc000000000ff0090400502010200
response: 000: 09 ff bf c0 00 00 00 00 ff 00 90 40 05 02 01 02 ...........@....
response: 010: 00                                              .
stefan@stein ~ $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 05 02 01 02 ...........@....
response: 010: 00                                              .

> To confirm it, please execute this command again:
> $ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
> 
> Response should be:
> 0c ff bf c0 00 00 00 00 ff 00 90 40 0[2345] 02 01 06 06

Nope, it is only
  0c ff bf c0 00 00 00 00 ff 00 90 40 0[2345] 02 01 02 00.
-- 
Stefan Richter
-=====-====- --=- ===--
http://arcgraph.de/sr/
