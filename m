From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Using ARRAY_SIZE macro when setting up ASoC audio
 map?
Date: Wed, 27 Feb 2008 15:11:51 +0200
Message-ID: <20080227151151.547a3669.jarkko.nikula@nokia.com>
References: <20080227134923.aa37870c.jarkko.nikula@nokia.com>
	<20080227123416.GA8730@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 722CA1038AB
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 14:12:38 +0100 (CET)
In-Reply-To: <20080227123416.GA8730@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Feb 2008 12:34:18 +0000
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Feb 27, 2008 at 01:49:23PM +0200, Jarkko Nikula wrote:
> > Does an example patch to spitz below make any sense? Yep, noticed
> > when forgot to add array terminator to own code :-)
> 
> Yes, sure.
>
Ok. Probably not worth to change now to n different drivers but worth
to take into account when reviewing new ones or doing some other
cleanups.

-- 
Jarkko
