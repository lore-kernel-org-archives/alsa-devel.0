From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Compiler warning - overriding codec compress type
Date: Mon, 18 Apr 2011 11:30:57 +0100
Message-ID: <20110418103056.GA9462@sirena.org.uk>
References: <4DABDC2E.9080103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D81671037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 12:31:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DABDC2E.9080103@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 17, 2011 at 11:37:34PM -0700, Patrick Lai wrote:

> I got a compiler warning soc-core.c: In function 
> 'snd_soc_instantiate_cards' warning: 'compress_type' may be used 
> uninitialized in this function. In reality, compress_type is defined as 
> local variable in snd_soc_instantiate_card().

Please *always* CC relevant maintainers on mails if you want them to be
read.

> My kernel version is 2.6.38. Has the warning being addressed in 2.6.39 
> or 2.6.40 patches? If not, after tracing through the code, I think the 
> fix should look like the following:

This is the sort of question that can easily be answered by building the
code...  I believe it's not an issue with current code but I've not
looked myself.
