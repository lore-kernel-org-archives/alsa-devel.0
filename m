From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Beginner to Alsa Development
Date: Thu, 12 Aug 2010 12:13:04 +0200
Message-ID: <4C63C930.3080802@canonical.com>
References: <000001cb3a06$5a5202d0$0ef60870$@in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9052D1038D5
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:13:07 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OjUmY-00069a-Sh
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 11:13:07 +0100
Received: from [88.83.60.91] (helo=[192.168.8.103])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1OjUmY-00089h-P0
	for alsa-devel@alsa-project.org; Thu, 12 Aug 2010 11:13:06 +0100
In-Reply-To: <000001cb3a06$5a5202d0$0ef60870$@in>
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

There is a small tutorial here, I don't know if it's outdated though:
http://www.suse.de/~mana/alsa090_howto.html

2010-08-12 12:08, Tejas skrev:
> Hello All,
> 
>                I am new to alsa interface development. I would like to write
> one application which accept *.pcm file as input and give playback of it on
> sound device on linux system. My requirement is to set sample rate 44100,
> channel 2 and access method is SND_PCM_ACCESS_RW_INTERLEAVED and data length
> is 16 bit little endian. 
> 
>  
> 
>                Can any oen guide me how can I start writing application in c
> file and which are those APIs which I need to take care and handling of
> different error codes. It is very urgent.
> 
>  
> 
>                Please correct me if I am wrong at anywhere.
> 
>  
> 
> -Tejas.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
