From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm9712 mono mixer
Date: Sat, 19 Jul 2008 10:22:21 +0100
Message-ID: <20080719092220.GA3103@sirena.org.uk>
References: <200807190051.25749.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D592224457
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jul 2008 11:22:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807190051.25749.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 19, 2008 at 12:51:25AM +0200, Marek Vasut wrote:

> this fixes typo in wm9712 codec which prevents it from registering all audio 
> routes (and thus working correctly). Please consider applying.
> 
> (Tested and works on palmtx, palmld and palmt5)

Looks right - thanks!

Acked-by: Mark Brown <brooie@opensource.wolfsonmicro.com>

BTW, when submitting patches it is more normal to include the patch in
the body of the e-mail rather than as an attachment.  It can make things
a bit more natural for automated tools for handling patches submitted
via e-mail.  See Documentation/email-clients.txt for some instructions
for setting up some e-mail clients to support this.  If you are doing
attachments it can be helpful to include the commit message in the patch
file in case the file gets separated from the e-mail.
