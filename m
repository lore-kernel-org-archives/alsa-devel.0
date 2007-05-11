From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Re: Getting a full device list
Date: Fri, 11 May 2007 19:01:41 +0200
Message-ID: <4644A175.4000004@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>	<4627B015.7030401@gmail.com>	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>	<4644455B.4080706@gmail.com>	<Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>	<46444E00.1040808@gmail.com>
	<s5hfy63iea8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 652EE2434E
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 19:01:49 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so632013ugf
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 10:01:48 -0700 (PDT)
In-Reply-To: <s5hfy63iea8.wl%tiwai@suse.de>
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
> You can override the values easily in user configuration, e.g. by
> adding the following line to ~/.asoundrc:
> 
> 	defaults.namehist.showall	on
> 
> To force to override even the variable type, you can add '!' modifier,
> 
> 	defaults.namehist.!showall	1

So global variables found in alsa.conf can be overridden in ~/.asoundrc.. I
didn't realise this either..

Thanks for the advice.

Nicholas
