From: Carlo Florendo <subscribermail@gmail.com>
Subject: Re: [LAD] How to get correct midi timings from ALSA
 using the library only
Date: Wed, 25 Jul 2007 16:51:46 +0800
Message-ID: <46A70F22.5010707@gmail.com>
References: <46A5BFDF.4040906@gmail.com>
	<1185272655.7458.1201738081@webmail.messagingengine.com>
	<46A69F4D.7050002@gmail.com>
	<1185351898.28416.1201921883@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.hq.astra.ph (unknown [202.78.101.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A4161038CA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 10:51:28 +0200 (CEST)
In-Reply-To: <1185351898.28416.1201921883@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Carlo Florendo wrote:
>> Clemens Ladisch wrote:
>>>> However, I wish to be able to make the sequencer or player work without the 
>>>> use of the ALSA queue nor the workaround in (2).
>>> Why?
>> Because the queue output and draining, AFAICS, is implemented in a blocking 
>> manner.
> 
> When non-blocking mode is set (see snd_seq_nonblock()),
> snd_seq_drain_output() does not block but writes only as many events to
> the kernel buffer as fit inside (or returns -EAGAIN if the kernel buffer
> is completely full).

Gee!  I haven't read the ALSA lib API docs that much but this sounds and 
looks like a solution to the problem :)

Thank you very much for the pointers and for all your patience.

> 
> 
> Regards,
> Clemens
> 

Best Regards,

Carlo



-- 
Carlo Florendo
Softare Engineer/Network Co-Administrator
Astra Philippines Inc.
UP-Ayala Technopark, Diliman 1101, Quezon City
Philippines
http://www.astra.ph

--
The Astra Group of Companies
5-3-11 Sekido, Tama City
Tokyo 206-0011, Japan
http://www.astra.co.jp
