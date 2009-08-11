From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 11 Aug 2009 11:47:33 +0100
Message-ID: <20090811104733.GA8221@rakim.wolfsonmicro.main>
References: <20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6FF024B6C
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 12:47:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2009 at 04:13:50PM +0530, Harsha, Priya wrote:

> Can you help me know which component/config file is responsible for
> creation of nodes in /dev/input? What am I missing here?

Normally this is done by either udev or static configuration.
