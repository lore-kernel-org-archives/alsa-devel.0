From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Clicking issues with the output of an Onyx
	Blackbird
Date: Sat, 15 Oct 2016 20:01:11 +0900
Message-ID: <de6d1a59-d5c3-6e04-4713-363b9ce6f305@sakamocchi.jp>
References: <CACF1cz+wRmDQVN6aDsFpPndSyAygwgHaQHyjxu0hcjh3vx+Txw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 6941B265142
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 13:01:16 +0200 (CEST)
In-Reply-To: <CACF1cz+wRmDQVN6aDsFpPndSyAygwgHaQHyjxu0hcjh3vx+Txw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jordi Torres <clubmajo@yahoo.es>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 13 2016 17:44, Jordi Torres wrote:
>> (CCed to alsa-devel)
> I sent this issue to alsa mailist 6 days ago but I supouse that hit
> the spam filter. Even I published an alsa-info
> http://www.alsa-project.org/db/?f=cb6745b6d0acdb5d9375096ec8dc008f6ff49cd7

You need to create your account to blast your messages to subscribers.

> When I read the wiki about reporting bugs, I understood that kernel
> related bugs goes to bugzilla.kernel.org and user-land bugs goes to
> the devel mail-list. So I supouse that I should sent this issue to the
> bugzilla as it's considered a kernel bug

I don't mind to receive bug reports in this mailing list, instead of
bugsilla. Both are OK to me.

>> Well, could I request you to gather information of packet sequence?
>
> Here is the trace of packets:
>
https://drive.google.com/file/d/0Bz44Dr5G2FeJSXBHMzc5WTFmOWs/view?usp=sharing
>
> The trace includes the opening of alsa device and playing a sine wave
> for 30 seconds

Thanks. I can diagnose incoming packets from your unit according to the
log. This is the result:

Isochronous channel 0:
Cycle count (sec): packets data-blocks
0: 0 0
4: 64 232.0
5: 16 48.0
7: 32 136.0
1: 16 88.0
6: 16 88.0
0: 16 96.0
2: 80 472.0
5: 5071 30424.0
6: 8000 48008.0
7: 8000 48000.0
0: 8000 48008.0
1: 8000 48000.0
2: 8000 48008.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48008.0
6: 8000 48000.0
7: 8000 48008.0
0: 8000 48000.0
1: 8000 48008.0
2: 8000 48000.0
3: 8000 48008.0
4: 8000 48000.0
5: 8000 48008.0
6: 8000 48000.0
7: 8000 48008.0
0: 8000 48000.0
1: 8000 48008.0
2: 8000 48000.0
3: 8000 48008.0
4: 8000 48000.0
5: 8000 48008.0
6: 8000 48000.0
7: 8000 48008.0
0: 8000 48000.0
1: 8000 48008.0
2: 8000 48000.0

Hm, in the beginning of packet streaming, your unit looks to transfer
packets intermittently.

In intermediate cycle count at 5 sec, your unit transferred packets
periodically. But the total count of data block is not exactly the same
as sampling transfer frequency. This means that your unit puts more PCM
samples than current sampling rate. One time every 2 second, your unit
put additional 8 samples. This quirk is the same as I can see with my
ImpactTwin.

In detail of my investigation for the other Dice-based units, please read:
[alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html

On the other hand, we can see that packet streaming engine on ALSA
firewire stack transfers data blocks at exactly the same as current
sampling transfer frequency.

Isochronous channel 1:
Cycle count (sec): packets data-blocks
0: 0 0
6: 96 576.0
0: 112 672.0
2: 160 960.0
5: 5057 30344.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0

Isochronous channel 2:
Cycle count (sec): packets data-blocks
0: 0 0
6: 80 480.0
0: 80 480.0
2: 144 864.0
5: 5039 30240.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0
3: 8000 48000.0
4: 8000 48000.0
5: 8000 48000.0
6: 8000 48000.0
7: 8000 48000.0
0: 8000 48000.0
1: 8000 48000.0
2: 8000 48000.0

In the beginning of both packet streams, we can see cycle jumps. I think
this comes from behaviours of Audacity or PortAudio v1.9. The
combination starts ALSA PCM substreams several times before continuous
PCM substreams.

Well, the mismatch between the number of data blocks per seconds from
Dice-based units and from ALSA firewire stack causes the de-sync of
device internal processing and generates periodical noise, currently I
guess.

> My linux box has two firewire ports I don't know the details about the
> host controller but could be feasible sniff the connection between the
> other computer with official drivers and the DAW? Could that be
> useful?
>
> PD: Resent due to using the wrong sender address

Please keep the continuity of 'in-reply-to' header field of messages so
that related messages are related to one message thread.


Regards

Takashi Sakamoto
