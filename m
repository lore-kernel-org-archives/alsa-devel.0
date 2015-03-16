From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Tue, 17 Mar 2015 07:47:01 +0900
Message-ID: <55075D65.20406@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 007F62619DB
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 23:47:07 +0100 (CET)
In-Reply-To: <55070F3B.7000509@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, damien@zamaudio.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Robin,

On May 17 2015 02:13, Robin Gareus wrote:
> On 03/16/2015 05:25 PM, Takashi Sakamoto wrote:
> [..]
>>
>> We can see the data in 7th MBLA data channel influences data in next
>> data block (data block is represented as 'frame' in driver code). The
>> pattern is what you discovered. In my understanding, this is the lack of
>> my implementation.
>>
>> Do you mean this issue?
>>
> 
> yes, precisely.

OK. Thanks for your confirmation.

> Though from the information Damien sent me it looked like it wraps
> around in the current frame, rather then progress to the next..
> 
> Anyway, in this case the original code at
> https://github.com/x42/003amdtp is also wrong and the driver will have
> to allocate space for the state and retain it for subsequent calls.

This idea may solve both issues that 'per-data block' and 'per-packet'.
I describe the detail later.

> Using a static on the stack won't work in case someone has multiple of
> those devices.

Oops, exactly. I forgot this case... Thanks.


This is another sample, with the last four data blocks in a CIP and the
first four data blocks in next CIP. You can see the continuous value in
data-block-counter (dbc) field in each CIP header.

020B00F0 9004D000
...
80000000 4000DA00 4000E500 40001B00 40002400 4000BC00 4000A300 40F04E1C
4000C100 4000DF00 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 40F0530D
40003D00 40004200 4000CE00
80000000 4000D100 4000EF00 40000000 40000000 40000000 40000000 40F0831C
40007D00 40005200 40003E00
80000000 40004100 4000CF00 40000000 40000000 40000000 40000000 40F0E477
40001C00 40002300 4000BD00

020B0000 9004E400
80000000 4000A200 40000E00 40006100 4000FF00 40000000 40000000 40F15FC1
40000000 40000000 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 40F1C387
4000DD00 4000E200 40001E00
80000000 40002100 4000BF00 40000000 40000000 40000000 40000000 40F1DDE5
4000E200 40001E00 40002100
80000000 4000BF00 40000000 40000000 40000000 40000000 40000000 40F19742
40009900 40009600 40009A00
...

We can see the pattern is carried to the data block in next packet. But
current implementation is not good for this case.


Regards

Takashi Sakamoto
