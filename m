From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] cs4231-lib: improved waiting
 after	mce_down (2nd rev)
Date: Tue, 11 Sep 2007 02:40:34 +0200
Message-ID: <46E5E402.40906@gmail.com>
References: <20070909221131.06372eb2.krzysztof.h1@gmail.com>	<s5hbqcaqkb8.wl%tiwai@suse.de>	<20070911004010.b9114b3e.krzysztof.h1@gmail.com>	<46E5C89E.4010607@gmail.com>	<s5hejh6ktk8.wl%tiwai@suse.de>
	<s5hd4wqkt5a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C9F9F243A6
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 02:40:38 +0200 (CEST)
In-Reply-To: <s5hd4wqkt5a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/11/2007 01:17 AM, Takashi Iwai wrote:

>> Actually, the code with msleep() was basically OK.  If more finer
>> check is needed, it can simply use msleep(1).  The point is to use
>> timer_after_eq() instead of loop count for the precise timeouts.
> 
> Could you check whether the below patch works?

Works for me on ISA CS4231 (behind an AZT1605). Earlier Krzysztof suggested 
that 2 ms may be optimum, but I'll leave that upto him.

Acked-by: Rene Herman <rene.herman@gmail.com>

Zzz,
Rene
