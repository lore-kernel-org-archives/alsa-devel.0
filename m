From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 14:37:13 -0800
Message-ID: <871vu2hskm.fsf@deeprootsystems.com>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
	<20090213133057.GC31085@sirena.org.uk>
	<87fxiijfi2.fsf@deeprootsystems.com>
	<20090213203109.GB6410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 81C93243B2
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 23:37:17 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so789988rvf.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 14:37:15 -0800 (PST)
In-Reply-To: <20090213203109.GB6410@sirena.org.uk> (Mark Brown's message of
	"Fri\, 13 Feb 2009 20\:31\:09 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: chaithrika@ti.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Fri, Feb 13, 2009 at 11:36:37AM -0800, Kevin Hilman wrote:
>
>> This patch is against DaVinci git[1], which still has some differences
>> compared to the upstream trees.
>
>> Below is a version of this patch against Linus' tree, with the SFFSDR
>> board changes from Hugo included.
>
> Applied, thanks.  Is there any plan in place for bringing the DaVinci
> tree into sync with mainline here?  It'd help avoid issues like this in
> future.

Yes, I am actively working on that.  However, I'm currently focusing
on the core arch/arm/mach-davinci/* code first, then will work on
bringing the rest of the drivers up to speed.

Kevin
