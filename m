From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 1/2] Add initial support of Mitac mioa701
 device SoC.
Date: Fri, 09 Jan 2009 13:20:38 +0000
Message-ID: <1231507238.4934.19.camel@vega.slimlogic.co.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk> <87iqopbj7r.fsf@free.fr>
	<20090109010233.GB29867@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 590AA243E5
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 14:20:49 +0100 (CET)
In-Reply-To: <20090109010233.GB29867@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-01-09 at 01:02 +0000, Mark Brown wrote:

> Right now my feeling is that we probably want to do at least some
> scenario stuff in kernel space and that what's sensible for a given
> machine will depend on both the capabilities of the machine (having both
> GSM and WiFi causes the number of use cases to get much larger, for
> example) and if there's hardware restrictions that need to be enforced
> (like not being able to use both speaker and headphones at the same
> time, which is fairly common but easily enforced without scenarios as
> such).

My feeling is that kernel based scenario really should be minimal to non
existent depending upon machine. If it has to be implemented then it
must be consistent across all devices (probably worth creating a
sound/core/scenario.c for others to use).

Imho it's far better to do most scenario in userspace due to increasing
driver complexity and slow driver scenario development speed (remember
the OSS driver pain involved with this). Userspace will additionally
give us a consistent API for applications and hopefully much better
adoption (esp if merged into alsa-lib / salsa).

Btw, I'll be releasing a new version of the ALSA scenario library early
Feb. http://www.slimlogic.co.uk/?page_id=7


Liam
