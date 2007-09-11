From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
	initial load
Date: Tue, 11 Sep 2007 22:42:23 +0200
Message-ID: <46E6FDAF.3050201@gmail.com>
References: <46E58D01.9080809@gmail.com>	
	<20070910234034.a052c957.krzysztof.h1@gmail.com>	
	<46E5BA6F.9070408@gmail.com>
	<8c74410a0709110156q2fccdf99o358a9fd27103dbc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B20010381C
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 22:42:32 +0200 (CEST)
In-Reply-To: <8c74410a0709110156q2fccdf99o358a9fd27103dbc3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/11/2007 10:56 AM, Krzysztof Helt wrote:

> Anyway, do you care to change this long snd_cs4231_busy_wait(chip) to
> the snd_cs4231_wait(chip) used in other functions to wait for ready
> bit?

That is, only drop the "huh?" bit? Yes, that should be okay. It looks a 
little off and I have a large testing pool if need be (CS4248, CS4231(A), 
CS4232/5/6/7/8 and 9)

Rene.
