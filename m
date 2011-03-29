From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] sound: asoc: Adding support for
	SPEAr13XX ASoC driver
Date: Tue, 29 Mar 2011 16:56:34 +0900
Message-ID: <20110329075633.GC29330@opensource.wolfsonmicro.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317150539.GF31411@opensource.wolfsonmicro.com>
	<4D91821D.5030300@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D02631038EB
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 09:56:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D91821D.5030300@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2011 at 12:24:21PM +0530, rajeev wrote:

> Could you please let me know where to put these Kconfig and Makefile either in platform driver or in m/c driver

If you're adding a new platform it's common to add the Kconfig and
Makefile last in a separate patch so you don't need to worry if the rest
of the patches build individually (but if you're adding a CODEC that
should include its own patch).  Otherwise just build the bits up as you
add them, the goal is that the tree should be buildable after each
patch.
