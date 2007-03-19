From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC] Sign offs for alsa-driver
	->	alsa-kernel	derived	works.
Date: Mon, 19 Mar 2007 10:53:48 +0000
Message-ID: <1174301628.5824.6.camel@localhost.localdomain>
References: <1173979821.27299.182.camel@batley.wolfsonmicro.main>
	<s5hfy85wgez.wl%tiwai@suse.de> <1174200705.4420.7.camel@matisseg>
	<s5hr6rljzhl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6rljzhl.wl%tiwai@suse.de>
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

On Mon, 2007-03-19 at 11:31 +0100, Takashi Iwai wrote:
> At Sun, 18 Mar 2007 07:51:45 +0100,
> Giorgio Padrin wrote:
> > Il giorno ven, 16/03/2007 alle 12.56 +0100, Takashi Iwai ha scritto:
> > > 
> > > So, in your case, basically you don't need a sign-off by Giorgio since
> > > "the patch" you wrote is different from his original one.
> > > 
> > > > If original author sign-off is not required for this situation, I can
> > > > resubmit the code.
> > > 
> > > I don't think resubmission is needed.
> > 
> > As long as that sign-off-by line is expunged from the submission, cause
> > not coming from me. For the health of the process.
> 
> Or, please check the patch and give a sign-off, so everyhing will be
> happy again.
> 
> As mentioned, a sign-off doesn't mean that the patch is from yours at
> all.  It means that it's reviewed and confirmed as a patch for merge.

That would be Acked-by where you review it and just confirm its ok by
you.

Signed-off-by means the patch passed through the hands of the person on
its way into mainline. The SoC patches that had my signed-off-by line
were correct as I'd passed them to Liam who collected them, then pushed
them upstream - the patches passed through both our hands.

In this case (as I understand it), Giorgio wrote some of the code it was
based on and therefore should get a mention in the commit message and
headers of the files concerned. If he agrees with the code, he can also
Ack it. He hasn't been directly part of the chain of submission though.

Regards,

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
