From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Tue, 13 May 2008 16:36:19 +0200
Message-ID: <20080513143619.GA1714@elte.hu>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
	<48243D86.7020504@keyaccess.nl> <20080509122828.GB10855@elte.hu>
	<4824D79C.7060303@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F8E124B1B
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 16:36:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4824D79C.7060303@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org


* Rene Herman <rene.herman@keyaccess.nl> wrote:

>> great, thanks Rene for catching this! Added this line to the patch as 
>> well:
>>
>>  Tested-by: Rene Herman <rene.herman@keyaccess.nl>
>
> Oh... it was rather significantly in the AM when I posted so I forgot 
> to mention in the haste to get this out of the way but it was Pete 
> Clements who reported the regression:
>
> http://www.nabble.com/Lost-Sound-from-2.6.24-to-2.6.25----CS4236-ISA-tc17062547.html
>
> He also tested it, so as long as we're name-mention-flattering 
> around...
>
> And this a good excuse to ask how you edit changelog after the fact. 
> Just reset/reapply and stuff or is there a "better" way? I fairly 
> frequently find myself wanting to do just that but it's a bit of a 
> mess when there's already commits on top.

generally we prefer append-only repositories for public trees.

But as long as you've not pushed it out to others yet, i.e. it's a 
purely local development tree, you can use two methods:

If it's just one commit in some devel branch that you want to put into a 
'fixes' branch one you can use git-cherry-pick --edit to shuffle it 
over.

For more complex scenarios you can use git-rebase --interactive to 
rebase your commits and to edit them. Replace the command "pick" with 
"edit" to change/fix the commit message. "squash" can be used to fold 
fixes.

	Ingo
