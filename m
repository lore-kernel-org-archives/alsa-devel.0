From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC] Sign offs for
	alsa-driver	->	alsa-kernel	derived	works.
Date: Mon, 19 Mar 2007 11:13:01 +0000
Message-ID: <1174302781.5824.10.camel@localhost.localdomain>
References: <1173979821.27299.182.camel@batley.wolfsonmicro.main>
	<s5hfy85wgez.wl%tiwai@suse.de> <1174200705.4420.7.camel@matisseg>
	<s5hr6rljzhl.wl%tiwai@suse.de>
	<1174301628.5824.6.camel@localhost.localdomain>
	<s5hircxjxye.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hircxjxye.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Giorgio Padrin <giorgio@mandarinlogiq.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-03-19 at 12:04 +0100, Takashi Iwai wrote:
> At Mon, 19 Mar 2007 10:53:48 +0000, Richard Purdie wrote:
> > That would be Acked-by where you review it and just confirm its ok by
> > you.
> > 
> > Signed-off-by means the patch passed through the hands of the person on
> > its way into mainline. The SoC patches that had my signed-off-by line
> > were correct as I'd passed them to Liam who collected them, then pushed
> > them upstream - the patches passed through both our hands.
> > 
> > In this case (as I understand it), Giorgio wrote some of the code it was
> > based on and therefore should get a mention in the commit message and
> > headers of the files concerned. If he agrees with the code, he can also
> > Ack it. He hasn't been directly part of the chain of submission though.
> 
> In the exact defintion, yes, you're correct.
> 
> But, a patch can be submitted from multiple paths, i.e. I may receive
> the very same patch from multiple persons at the same time.  In that
> case, Signed-off-by isn't completely wrong (except for the time-line
> :-)
> 
> Note that we cannot modify the commit log on public Git or HG tree
> easily, and sign-offs are in commit logs.  So, removing a sign-off
> from the public tree should be the very last choice.

I understand that. I'm mainly concerned with people getting it right in
future which I think it why Liam asked the original question. For the
reason you mention, that specific case might need a different handling
for the reason you've mentioned.

Cheers,

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
