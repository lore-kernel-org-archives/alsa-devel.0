From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ESI Juli@/Ice1724
Date: Thu, 27 Mar 2008 09:13:21 +0100
Message-ID: <47EB5721.7090403@insite.cz>
References: <dbfa5dfc0803262347y71a7a22p27ea2a2b133c9946@mail.gmail.com>	
	<47EB491C.3050506@insite.cz>
	<dbfa5dfc0803270105j4691bc68rcb74e11d3ccf21a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A072243BE
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 09:13:27 +0100 (CET)
In-Reply-To: <dbfa5dfc0803270105j4691bc68rcb74e11d3ccf21a0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Trompell <mark@foresightlinux.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>
>>  The discussed problems were about opening the MIDI device. It seems
>>  unlikely audacity would be touching midi.
> 
> I have to look a bit deeper into that, but it's hard to investigate,
> when your System locks and you have to turn the machine off and boot
> again.

I understand, I went through the same with Rosegarden. Try recording 
with arecord, whether you get a lockup.

> 
>>  Did you use the new driver in HG repository? I tested recording with
>>  arecord.
> 
> Not yet, will try, asap.

If it is the problem with MIDI, the new driver will not help, as it is 
not fix yet.

Pavel
