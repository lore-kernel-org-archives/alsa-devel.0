From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/3] ASoC: davinci-pcm: add cpu-dai health
	callbacks
Date: Tue, 4 Oct 2011 12:06:47 +0100
Message-ID: <20111004110646.GJ3250@opensource.wolfsonmicro.com>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
	<beb331a90431ab4dfefedc45f53e686df3bc3f61.1317417232.git.bengardiner@nanometrics.ca>
	<20111002185434.GH2857@opensource.wolfsonmicro.com>
	<CAPcSpELVrSNCT4bZ9p+NL_ti7+sP=KVf006j8xP9eM9_yF0Kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11366245CE
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:06:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPcSpELVrSNCT4bZ9p+NL_ti7+sP=KVf006j8xP9eM9_yF0Kvw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 10:05:45PM -0400, Ben Gardiner wrote:

> From your other email I see now that the intended behaviour can be
> accomplished entirely in the application. Returning _POS_XRUN should
> be sufficient here in ASoC.

OK, great - I was worried this might get complicated but if the drivers
can just punt the decision to userspace that makes life much easier.
