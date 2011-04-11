From: <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Lower the OSC
 calibration time
Date: Mon, 11 Apr 2011 14:51:41 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0274F181C@008-AM1MPN1-022.mgdnok.nokia.com>
References: <1302526664-1497-1-git-send-email-peter.ujfalusi@nokia.com>,
	<20110411130532.GC11072@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 4073810381E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 16:51:51 +0200 (CEST)
In-Reply-To: <20110411130532.GC11072@qtel.sh.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: guanqun.lu@intel.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> ________________________________________
> From: ext Lu Guanqun [guanqun.lu@intel.com]
> Sent: Monday, April 11, 2011 16:05
> To: Ujfalusi Peter (Nokia-SD/Tampere)
> Cc: alsa-devel@alsa-project.org; Mark Brown; Liam Girdwood
> Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320dac33: Lower the OSC calibration time
> 
> On Mon, Apr 11, 2011 at 08:57:44PM +0800, Peter Ujfalusi wrote:
> > To get correct calibration, we can decrease the time
> > needed for the OSC to calibrate itself.
> > With this change we can safe ~15ms in the OSC
> 
> s/safe/save/

Argh, thanks for noticing it, I'll resend it with the fixed message.

> 
> > calibration phase.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Peter
