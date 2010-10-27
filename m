From: Mohammad Bahathir Hashim <bahathir@penguin.localhost>
Subject: Re: snd-hda-intel (Cirrus Logic CS4206): MacBookPro6,
 2 : No S/PDIF with Linux 2.6.36C
Date: Wed, 27 Oct 2010 03:17:27 +0000 (UTC)
Message-ID: <ia85k6$3f8$1@dough.gmane.org>
References: <loom.20101026T061309-466@post.gmane.org>
	<4CC6D160.3090008@colin.guthr.ie>
Reply-To: bahathir@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8048F2458E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Oct 2010 05:17:37 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PAwW8-0001nI-Qr
	for alsa-devel@alsa-project.org; Wed, 27 Oct 2010 05:17:36 +0200
Received: from 203.106.17.237 ([203.106.17.237])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2010 05:17:36 +0200
Received: from bahathir by 203.106.17.237 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2010 05:17:36 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-10-26, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> 'Twas brillig, and Mohammad Bahathir Hashim at 26/10/10 06:08 did gyre
> and gimble:
>> Hi,
>> I want to use MacBook Pro (6,2) Mid-2010 15" with GNU/Linux all the time.
>> IMHO, GNU/Linux provides me the best performance and flexibility for
>> audio and video. 
>> 
>> Problem 1:
>> No SPDIF when using Linux 2.6.36, but it working fine with 2.6.35
>> 
>> Problem  2 ? :
>> xFront Speaker -> controls the woofer sound level
>> Surround -> controls the left and right channel speakers' sound level.
>> 
>> Both kernels 2.6.3[56] show the same problem/feature :). 
>
>
> My guess at the fix:
>
> ALSA: hda - Fix wrong SPDIF NID assignment for CA0110
>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=24b55c69b66eb2a122842820ec14ab215fc8572f
>
> (the base64 encoding of your alsa-info attachment didn't come through in
> a friendly way so I didn't bother decoding it, and hence this is just a
> guess)
>
> Col
>



Sorry for the inconviences.

2.6.36 + Takashi Iwai's recent intel-hda patches which I found in this group.
http://www.alsa-project.org/db/?f=b999d5cb69d36c83544235039d502c61e66b7794

2.6.35
http://www.alsa-project.org/db/?f=cf38000305da6b77fb388c83bb7386b74b96f61f
