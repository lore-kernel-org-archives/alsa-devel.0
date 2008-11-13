From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Thu, 13 Nov 2008 16:40:03 +0100
Message-ID: <cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<20081113151701.GG31592@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B7FE10380E
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 16:40:04 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so983689rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 07:40:03 -0800 (PST)
In-Reply-To: <20081113151701.GG31592@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 4:17 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Nov 13, 2008 at 03:57:08PM +0100, christian pellegrin wrote:
>
>>
>> but this really could be "playing with DMA" since I'm not sure why
>> there is a 1 (since min_period is 2 I would guess 2 is the right
>> value). Anyway with this change play and capture work well.
>
> See the commit log - the underlying DMA code restricts the number of
> buffers that can be queued up prior to the start of DMA.
>
>>

AFAIK it's limited to 2 transfers, one loaded and one running. It
could beneficial to have more of them (so the DMA doesn't stop if one
interrupt is delayed for too much time). But I don't know if it's so
critical. A period (4k) with cd quality sound takes 23 ms to be
played. An embedded system not responding to irqs for all this time
probably has worse issues.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
