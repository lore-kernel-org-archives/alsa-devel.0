From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 06/13] speakers: Change the way to make PCM
 rules/constraints
Date: Thu, 30 Jan 2014 15:21:17 +0100
Message-ID: <20140130152117.186f08d5@stein>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-7-git-send-email-o-takashi@sakamocchi.jp>
 <20140112131855.71976e86@stein> <52D2AA48.3020203@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FED32654AD
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 15:21:20 +0100 (CET)
In-Reply-To: <52D2AA48.3020203@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 12 Takashi Sakamoto wrote:
> Hi Stefan,
> 
>  > I have got both devices.  I could perform specific tests with them if
>  > you want and give me instructions.  It can be a very slow process
>  > though because I have got almost no spare time, at least throughout
>  > January and February.
> 
> Thank you. Please confirm these items below with Clemens' jujuutils when 
> you have a free  time:

Thanks for these straightforward instructions.  Here are the results.

> 1.They have both iPCR/oPCR.
>   $ ./firewire-request /dev/fw1 read 0xfffff0000900 (oMPR)
>   $ ./firewire-request /dev/fw1 read 0xfffff0000980 (iMPR)
> If they have, I can apply the same way to change sampling rate for all 
> of models.

LaCie Speakers:
---------------
$ firewire-request /dev/fw7 read 0xfffff0000900
result: 80ff0000
$ firewire-request /dev/fw7 read 0xfffff0000980
result: 80ff0001

Griffin FireWave:
-----------------
$ firewire-request /dev/fw8 read 0xfffff0000900
result: 80ff0000
$ firewire-request /dev/fw8 read 0xfffff0000980
result: 80ff0001


> 2.They can respond to 'SINGLE' subfunction of 'AV/C Stream Format 
> Information' command.
>    $ ./firewire-request /dev/fw1 fcp  0x01ffbfc000000000ffffffff
>     response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
>     response: 010: 06
>    This is an example of Behringer F-Control A 202(OXFW970).

LaCie Speakers:
---------------
$ firewire-request /dev/fw7 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 ...........@....
response: 010: 06                                              .

Griffin FireWave:
-----------------
$ firewire-request /dev/fw8 fcp 0x01ffbfc000000000ffffffff
response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 06 ...........@....
response: 010: 06                                              .


> 3.They can respond to 'LIST' subfunction of 'AV/C Stream Format 
> Information' command.
>    $ ./firewire-request /dev/fw1 fcp  0x01ffbfc100000000ffff01ff
>    I have no devices which supports this command. I guess OXFW971 
> supports this.

LaCie Speakers:
---------------
$ firewire-request /dev/fw7 fcp 0x01ffbfc100000000ffff01ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 01 90 40 03 02 01 ............@...
response: 010: 02 06                                           ..

Griffin FireWave:
-----------------
$ firewire-request /dev/fw8 fcp 0x01ffbfc100000000ffff01ff
response: 000: 0c ff bf c1 00 00 00 00 ff 00 01 90 40 02 02 01 ............@...
response: 010: 06 06                                           ..

-- 
Stefan Richter
-=====-====- ---= ====-
http://arcgraph.de/sr/
