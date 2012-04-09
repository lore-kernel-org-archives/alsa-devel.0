From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from
 sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 21:17:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204092112320.13925@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net>
	<alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 77C7A24523
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 21:17:06 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1204090201160.24006@pobox.suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Apr 2012, Jiri Kosina wrote:

> On Mon, 9 Apr 2012, Jesper Juhl wrote:
> 
> > While reading through sound/soc/codecs/wm8994.c I noticed a fair
> > amount of trailing whitespace. This patch gets rid of it.
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> 
> Jesper,
> 
> is it really worth it?

Maybe not. I just noticed it while I was reading through the file for 
other purposes and it annoyed me.


> The code should have been fixed before merging, 
> yes, but once it's there, such fixups tend to only make people angry 
> (because they have to do unnecessary extra steps during git blame).
> 

I think it's nice to get little things like this cleaned up, but at the 
same time I don't want to annoy other people.
I won't yell if you decide to just drop this patch.


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
