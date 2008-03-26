From: kyr <corali@freemail.gr>
Subject: Re: ALSA driver for Native Instruments sound hardware
Date: Wed, 26 Mar 2008 19:53:01 +0200
Message-ID: <47EA8D7D.8090807@freemail.gr>
References: 20070326161003.GB20122@ipxXXXXX <47E3B2F4.502@freemail.gr>
	<B0A4798E-638E-450B-A810-A966271FCD25@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kane.otenet.gr (kane.otenet.gr [195.170.0.77])
	by alsa0.perex.cz (Postfix) with ESMTP id F160A103802
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 18:56:26 +0100 (CET)
In-Reply-To: <B0A4798E-638E-450B-A810-A966271FCD25@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

O/H Daniel Mack ??????:
> Hi,
>
> On Mar 21, 2008, at 2:07 PM, kyr wrote:
>> I'd like to know if this driver support all of the 8 inputs/outputs
>> channels,
>> and if someone test it with xwax (xwax.co.uk).
>
> All inputs and outputs are supported, and the developer of xwax wanted 
> to test his software with this interface. However, I don't know about 
> his results or if he ever really did it. Maybe ask on their mailing list?
>
> Best regards,
> Daniel
>
>
Daniel hi,
There is a xwax user with the audio8dj interface but he has some trouble 
to get it work well with xwax.
The device is working almost well with plughw:1,0,0 for the first 
channel and plughw:1,0,1 for the second one.
But with very high latency.
Also refers that the alsamixer does not have any adjustments for in/outs.
How can you adjust the input/output levels? and the frequency? 44100, 
48000 or 96000Hz?

Thanks in advance,
Kyriakos
