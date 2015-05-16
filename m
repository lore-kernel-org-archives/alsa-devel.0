From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Behringer FCA 202 packet dump (Re: [PATCH 1/4] ALSA:
 firewire-lib: add buffer-over-run protection at receiving more data blocks
 than expected)
Date: Sat, 16 May 2015 20:30:01 +0900
Message-ID: <55572A39.6010509@sakamocchi.jp>
References: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
 <1431775365-25211-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8739B2606EE
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 13:30:06 +0200 (CEST)
In-Reply-To: <1431775365-25211-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 16 2015 20:22, Takashi Sakamoto wrote:
> But, Behringer F-Control Audio 202 (based on OXFW 970) has a quirk to
> postpone transferring isochronous packet till finish handling any
> asynchronous packets. In this case, this model is lazy, transfers no
> packets during several cycle-start packets. After finishing, this model
> pushes required data in next isochronous packet. As a result, the
> packet include more data blocks than IEC 61883-6 defines.

This is an actual packet dump. We can see this model postpone
transferring packets during handling asynchronous transaction.

FYI

-- Time expressed in clock-ticks of 10.172526 nSec
19657542078 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F3F024 speed=100
19657546326 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  02020072 900002E4 40FFFF8B
40000005   [...r....@...@...]
                               0010:  40FFFFD8 40FFFFFD 40FFFF37
40FFFFA5   [@...@...@..7@...]
                               0020:  40FFFE81 40FFFF2F
    [@...@../]
19657554363 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F40024 speed=100
19657559477 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  02020076 90000351 40FFFF1C
40FFFF95   [...v...Q@...@...]
                               0010:  40FFFF01 40FFFEF6 40FFFF2E
40FFFF77   [@...@...@...@..w]
                               0020:  40FFFEE9 40FFFF72
    [@...@..r]
19657566647 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F41024 speed=100
19657570253 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  0202007A 90000244 40FFFF11
40FFFF80   [...z...D@...@...]
                               0010:  40FFFF2A 40FFFFA7 40FFFF40
40FFFF71   [@..*@...@..@@..q]
                               0020:  40FFFF0E 40FFFFB1
    [@...@...]
19657578933 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F42024 speed=100
19657582987 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  0202007E 900002B4 40FFFF8C
40FFFFC5   [...~....@...@...]
                               0010:  40FFFF79 40FFFFBB 40FFFFDE
40FFFFE0   [@..y@...@...@...]
                               0020:  40FFFFF2 40000031
    [@...@..1]
19657591217 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F43024 speed=100
19657595721 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  02020082 90000324 4000004C
4000004B   [.......$@..L@..K]
                               0010:  40000054 40FFFFF9 4000004D
40FFFFFE   [@..T@...@..M@...]
                               0020:  40000053 4000003F
    [@..S@..?]
19657600127 ReadReq        dst=0xFFC2 label=36 rcode=retry_X src=0xFFC3
offset=0xFFFFF0000904 speed=400 ack=ack_pending
19657603503 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F44024 speed=100
19657615788 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F45024 speed=100
19657628072 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F46024 speed=100
19657633918 ReadResp       dst=0xFFC3 label=36 rcode=retry_X src=0xFFC2
response=resp_complete data=0x81008042 speed=400 ack=ack_complete
19657640358 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F47024 speed=100
19657644228 Streaming      length=136 tag=1 channel=0 synchronization=0
speed=400
                               0000:  02020086 90000257 40FFFFE9
4000003C   [.......W@...@..<]
                               0010:  40000000 40FFFFE2 40FFFFDF
40FFFFD9   [@...@...@...@...]
                               0020:  40000010 40000024 40FFFF6E
4000000B   [@...@..$@..n@...]
                               0030:  40FFFFC7 40FFFFE8 40FFFFE6
40FFFFAF   [@...@...@...@...]
                               0040:  40FFFFE1 4000002A 40000039
4000004A   [@...@..*@..9@..J]
                               0050:  40000055 40000043 40000091
400000C0   [@..U@..C@...@...]
                               0060:  40000089 40000010 40FFFFEF
40FFFFE7   [@...@...@...@...]
                               0070:  40000036 4000001D 40FFFFF8
40FFFFD5   [@..6@...@...@...]
                               0080:  4000001C 40000014
    [@...@...]
19657652642 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F48024 speed=100
19657657066 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  02020096 900002F1 40FFFFC2
40FFFF9F   [........@...@...]
                               0010:  40FFFFC1 4000000A 4000002A
40000018   [@...@...@..*@...]
                               0020:  40FFFFA5 40FFFFD5
    [@...@...]
19657664928 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F49024 speed=100
19657670106 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  0202009A 90000380 40000044
40000053   [........@..D@..S]
                               0010:  40000050 40000046 40000086
4000003A   [@..P@..F@...@..:]
                               0020:  4000006D 4000002D
    [@..m@..-]
19657677213 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F4A024 speed=100
19657680881 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  0202009E 90000253 4000006A
40000047   [.......S@..j@..G]
                               0010:  40000056 4000000A 40000074
4000001F   [@..V@...@..t@...]
                               0020:  4000004A 4000004A
    [@..J@..J]
19657689497 CycleStart     dst=0xFFFF label=0 rcode=retry_1 src=0xFFC3
offset=0xFFFFF0000200 cycle_time_data=0x58F4B024 speed=100
19657693615 Streaming      length=40 tag=1 channel=0 synchronization=0
speed=400
                               0000:  020200A2 900002C4 40000030
40000014   [........@..0@...]
                               0010:  4000002F 4000002D 40000013
4000001A   [@../@..-@...@...]
                               0020:  4000002F 40FFFFBE
    [@../@...]


Regards

Takashi Sakamoto
