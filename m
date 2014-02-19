From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Add support for
 multiple machine drivers per platform
Date: Wed, 19 Feb 2014 16:34:48 +0000
Message-ID: <1392827688.7077.0.camel@loki>
References: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140219161544.GM2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 95300265A85
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:35:19 +0100 (CET)
In-Reply-To: <20140219161544.GM2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-02-20 at 01:15 +0900, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 04:35:58PM +0200, Jarkko Nikula wrote:
> 
> > Matching machine driver is found by looking at ACPI ID which would best
> > match with the driver. Typically this would be the ACPI ID of audio codec
> > but is not tied to it.
> 
> You're going to need DMI matching as well, there's going to be quirks of
> some kind.  Otherwise this looks fine if an ugly way of doing it,
> assuming Liam is happy.

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
