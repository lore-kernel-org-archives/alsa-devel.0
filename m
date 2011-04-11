From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Mon, 11 Apr 2011 16:54:20 -0700
Message-ID: <20110411235418.GH29405@opensource.wolfsonmicro.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411125318.GA11072@qtel.sh.intel.com>
	<20110411133500.GA24973@opensource.wolfsonmicro.com>
	<20110411150937.GA12824@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA4E010383C
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 01:54:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110411150937.GA12824@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 11:09:37PM +0800, Lu Guanqun wrote:
> On Mon, Apr 11, 2011 at 09:35:01PM +0800, Mark Brown wrote:

> > This is only for devices that support more than one control interface.
> > If the device only supports one control interface there is no need to
> > make anything conditional.

> Well, but there are many codecs which support only one control interface
> while having this #ifdef condition...

Usually you'll find that these are devices which support multiple
control interfaces but where the driver has only implemented one so far
for some reason.
