From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:11:19 +0200
Message-ID: <4DF9E4D7.9090309@metafoo.de>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>	<1308079626-31239-2-git-send-email-zonque@gmail.com>	<20110615150516.GC2806@opensource.wolfsonmicro.com>	<20110615205329.GA7445@sig21.net>	<4DF9C13A.2000205@metafoo.de>	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>	<20110616101313.GB5262@opensource.wolfsonmicro.com>
	<BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5616510381B
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:12:45 +0200 (CEST)
In-Reply-To: <BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 06/16/2011 01:03 PM, Daniel Mack wrote:
> On Thu, Jun 16, 2011 at 12:13 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Jun 16, 2011 at 11:51:20AM +0200, Daniel Mack wrote:
>>
>>> # amixer cget numid=39
>>> numid=39,iface=MIXER,name='Limiter1 Attack Threshold (DRC Mode)'
>>>   ; type=INTEGER,access=rw---R--,values=1,min=0,max=16,step=0
>>>   : values=9
>>>   | dBrange-
>>> 0x00000000,0x00000007,0x00000001,0x00000008,0xfffff3e4,0x000000c8,0x00000008,0x0000000d,0x00000001,0x00000008,0xfffff9c0,0x00000064,0x0000000e,0x00000010,0x00000001,0x00000008,0xfffffc18,0x0000012c,
>>
>>> Is there a way to get more descriptive information about possible
>>> values for such controls?
>>
>> This looks rather like a buggy userspace - are you sure you're using a
>> current version?
> 
> # amixer --version
> amixer version 1.0.24.2
> 
> This is indeed strange, and I can't see how I use the API in any
> illegal way. Any other way to debug this?
> 
There seems to be a bug in amixer, please try:

diff --git a/amixer/amixer.c b/amixer/amixer.c
index a177288..c7b93b7 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -517,7 +517,7 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 #ifdef SND_CTL_TLVT_DB_RANGE
 	case SND_CTL_TLVT_DB_RANGE:
 		printf("dBrange-\n");
-		if ((size / (6 * sizeof(unsigned int))) != 0) {
+		if ((size % (6 * sizeof(unsigned int))) != 0) {
 			while (size > 0) {
 				printf("0x%08x,", tlv[idx++]);
 				size -= sizeof(unsigned int);
@@ -529,7 +529,7 @@ static void decode_tlv(unsigned int spaces, unsigned int *tlv, unsigned int tlv_
 			print_spaces(spaces + 2);
 			printf("rangemin=%i,", tlv[0]);
 			printf(",rangemax=%i\n", tlv[1]);
-			decode_tlv(spaces + 4, tlv + 2, 6 * sizeof(unsigned int));
+			decode_tlv(spaces + 4, tlv + 2, 4 * sizeof(unsigned int));
 			idx += 6 * sizeof(unsigned int);
 		}
 		break;
