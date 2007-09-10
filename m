From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
	initial load
Date: Mon, 10 Sep 2007 23:45:33 +0200
Message-ID: <46E5BAFD.20702@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<20070910234034.a052c957.krzysztof.h1@gmail.com>
	<46E5BA6F.9070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C992424445
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 23:52:32 +0200 (CEST)
In-Reply-To: <46E5BA6F.9070408@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/10/2007 11:43 PM, Rene Herman wrote:

> On 09/10/2007 11:40 PM, Krzysztof Helt wrote:

>> The snd_cs4231_busy_wait(chip) is not needed any more here.
> 
> I believe it is. I glanced over the CS4232 datasheet (note how cs4232 
> uses snd-cs4332-lib) and it adds a point 4 (see page 53):

I need to stop this annoying replying-to-myself, but my fingers aren't 
cooperating. snd-cs4231-lib.

> * Wait until 80h NOT returned
> 
> I didn't read closely, so feel free to point out if I'm misinterpreting 
> that.

Rene.
