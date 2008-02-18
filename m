From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 15:22:59 +0000
Message-ID: <20080218152259.GA7939@rakim.wolfsonmicro.main>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF6381038E1
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:23:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203345949.4063.8.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 08:45:49AM -0600, Brian Austin wrote:
> I was under the impression that the ASoc v1 ties the codec to a specific
> machine, and that v2 eliminates that need.  Is that a correct
> assumption?

No, codec drivers shouldn't be tied to a specific platform in either
version - the main new feature in v2 from the point of view of codec
support is that it allows a machine to have more than one codec at once,
but that's not a change that affects the codec driver.
