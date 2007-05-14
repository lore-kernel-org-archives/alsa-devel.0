From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Re: Getting a full device list
Date: Mon, 14 May 2007 11:27:38 +0200
Message-ID: <46482B8A.9080604@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>	<4627B015.7030401@gmail.com>	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>	<4644455B.4080706@gmail.com>	<Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>	<46444E00.1040808@gmail.com>	<s5hfy63iea8.wl%tiwai@suse.de>	<46481FA0.8050803@gmail.com>
	<s5hhcqfhifg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC7024725
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 11:27:43 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so919666ugf
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 02:27:43 -0700 (PDT)
In-Reply-To: <s5hhcqfhifg.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 14 May 2007 10:36:48 +0200,
> Nicholas Smethurst wrote:
>> Takashi Iwai wrote:
>>> You can override the values easily in user configuration, e.g. by
>>> adding the following line to ~/.asoundrc:
>>>
>>> 	defaults.namehist.showall	on
>>>
>>> To force to override even the variable type, you can add '!' modifier,
>>>
>>> 	defaults.namehist.!showall	1
>>>
>> Well I tried doing both of the above in ~/.asoundrc, but I'm still not getting
>> any listing of the pcm hw or plughw devices, or any plugins.
> 
> A typo of "namehint", sorry.
> 
> 
> Takashi
> 

I did see the typo before, and I corrected it before testing.. I had used:

	defaults.namehint.showall on
and
	defaults.namehint.!showall 1

for my tests - my results are in the previous email.
