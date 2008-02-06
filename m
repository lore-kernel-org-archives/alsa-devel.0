From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: problems with es1688 isa card on etch and lenny
 (ok	with sarge)
Date: Wed, 06 Feb 2008 20:47:30 +0100
Message-ID: <47AA0ED2.8070003@keyaccess.nl>
References: <f5976be10802051505x61480bbdq8fe61845b3c89470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1818D10392E
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 20:46:23 +0100 (CET)
In-Reply-To: <f5976be10802051505x61480bbdq8fe61845b3c89470@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norayr Chilingaryan <gnorayr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06-02-08 00:05, Norayr Chilingaryan wrote:

> I have an old notebook with ISA sound card which is detected by alsaconf 
> as es18xx, or es1688 or sb16 and works. The problem is appeared when I 
> replaced Debian Sarge with Debian Etch, and when I upgraded Etch to Lenny
> (i. e. with  alsa versions in that distros). So, alsaconf detects and
> configures a sound driver, it works, but after restart to have a sound I
> must run alsaconf again. I think something is changed in the recent alsa
> distributions which probably deals with debian configuration of isa
> cards.

I'm afraid you're probably better of asking somewhere Debian specific. The 
solution is probably as easy as sticking in a

alias snd-card-0 snd-es18xx

somewhere appropriate but where somewhere appropriate is and why it's 
different then before I don't know.

Rene.
