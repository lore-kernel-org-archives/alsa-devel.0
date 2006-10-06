From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: RME 9632 - Problem half solved
Date: Fri, 6 Oct 2006 15:53:55 +0200
Message-ID: <20061006135355.GA22664@trinnov.com>
References: <20061003103712.GA12508@trinnov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061003103712.GA12508@trinnov.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Remy Bruno <remy.bruno@trinnov.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hello,

I solved the matrix problem. In fact, it was quite obvious by looking at the
hdsp driver code. The 9632 card was considered as a 9652 regarding the matrix,
and so the offsets in the matrix were wrong. See the attached patch. I think
the "switch()" statement should be replaced by an "if (hdsp->firmware_rev >=
0x96)", which would allow the next firmwares of the hdsp9632 to be considered
as hdsp9632 and not as 9652.

For the frequency problem, I got an answer from RME which explains that another
register needs to be set (together with the freq0, 1, 2 bits of the control
register). This register is the "DDS" register. Here is how it should be
computed:
UINT64 CalcDDSValue(UINT64 rate)
{
        if (rate >= 112000)
                rate /= 4;
        else if (rate >= 56000)
                rate /= 2;

        return 104857600000000 / rate;
}
MemBase[FREQ_REG] = (ULONG)CalcDDSValue(new_rate)

Any ideas of what the offset of this register is? If not, I will ask him. BTW,
this register exists only for the 9632 and not for the 9652.

Regards,

Remy


On Tuesday 03 October at 12:37, Remy Bruno wrote:
> Hello,
> 
> I'm having a strange problem with an RME HDSP 9632 card I recently bought. I've
> contacted RME, but would like to know if somebody here is having the same
> problem, or if there is a known issue about this (and if possible, a
> workaround).
> 
> Start of the story: a couple of monthes ago (let's say about one year, but I'm
> not sure of the time-scale), I got a RME HDSP 9632. Alsa driver was working
> perfectly, I got the 12 I/O (16 with the additionnal add-on cards), the mixer
> matrix worked as expected (mixer params = src,dest,32768 with src=dest+16 for
> sending playback channels to audio outputs). After an hardware problem with the
> card (I plugged the analog add-on card while it was running, which burned the
> card!), I had to get a new one. I didn't manage to get this new card work, so I
> suspected a specific problem with this new card. More recently (one week ago),
> I needed to use an RME9632, so I got a new one, and I'm having about the same
> problem than with the 2nd one:
> - card does not work in master. Everything is as if it ran at 24kHz (sound
>   plays slowly), even if the card pretends to run at the desired sample rate
>   (say 44.1 or 48kHz). So master mode is unusable.
>   Master worked with the 1st card.
> - in slave, it seems to be more or less OK, but the matrix behavior is
>   extremely weird. For sending playback channels 9,10,11,12 on outputs
>   9,10,11,12 (SPDIF & analog), I need to put the value 32768 in the following
>   coefficients: (62, 4), (1, 6), (24, 6), (15, 7)
>   With the first (now dead) card, I used the normal following matrix
>   coefficients: (24,8) (25,9), (26, 10), (27, 11)
> 
> Any idea?
> 
> Thanks
> 
> Remy
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="hdsp.c.diff"

--- hdsp.c.org	2006-09-29 13:40:37.000000000 +0200
+++ hdsp.c	2006-10-06 15:26:44.000000000 +0200
@@ -598,6 +598,7 @@
 		return (64 * out) + (32 + (in));
 	case 0x96:
 	case 0x97:
+	case 0x98:
 		return (32 * out) + (16 + (in));
 	default:
 		return (52 * out) + (26 + (in));
@@ -611,6 +612,7 @@
 		return (64 * out) + in;
 	case 0x96:
 	case 0x97:
+	case 0x98:
 		return (32 * out) + in;
 	default:
 		return (52 * out) + in;

--5vNYLRcllDrimb99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--5vNYLRcllDrimb99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--5vNYLRcllDrimb99--
