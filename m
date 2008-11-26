From: "Karl Dyson" <karl@lil-voodoo.co.uk>
Subject: Re: Alsa Driver Development - General Concepts
Date: Wed, 26 Nov 2008 16:27:15 -0000 (UTC)
Message-ID: <18854.12.4.27.248.1227716835.squirrel@www.lil-voodoo.co.uk>
References: <42406.12.4.27.248.1227714506.squirrel@www.lil-voodoo.co.uk>
	<200811261606.58772.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from harpoon.unitedhosting.co.uk (harpoon.unitedhosting.co.uk
	[83.223.124.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D0C24729
	for <Alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 17:27:17 +0100 (CET)
Received: from www.lil-voodoo.co.uk (localhost.localdomain [127.0.0.1])
	by harpoon.unitedhosting.co.uk (8.13.1/8.13.1) with ESMTP id
	mAQGRFBn013055
	for <Alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 16:27:15 GMT
In-Reply-To: <200811261606.58772.maillist@superlative.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Keith,

> I would be careful on what you mean by "not recognised by the kernel". In
> a typical distro the "recognition" is not done by the kernel, but by some
> external utility which scans the hardware and attempts to associate the
> devices with drivers. Things like kudzu, harddrake, hotplugging and udev
> are things to research here.
Yeah I didn't think through what I was saying there. The devices are
recognised by the various parts of Linux (openSuse in this case) but no
drivers are loaded.

I think I'm going to have to get used to writing drivers at some point in
my Linux life, so might as well start with these simpler devices - even if
some of the existing stuff would work given a few config changes.

Cheers mate.
