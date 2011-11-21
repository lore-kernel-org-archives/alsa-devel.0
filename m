From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: Exporting playback and capture capability to user
 space
Date: Mon, 21 Nov 2011 11:53:46 +0530
Message-ID: <1321856626.1516.208.camel@vkoul-udesk3>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com> <4EC50DB2.6090009@st.com>
	<4EC9E656.1050706@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ED59245AE
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 07:27:40 +0100 (CET)
In-Reply-To: <4EC9E656.1050706@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-11-21 at 11:19 +0530, Rajeev kumar wrote:
> Hello Mark
> 
> Could you please help me by answering these questions?
> 
> Best Regards
> Rajeev
> 
Pls don't top-post!!
> On 11/17/2011 7:05 PM, Rajeev kumar wrote:
> > Hello Mark
> >
> > I have a single codec with playback and capture capability. We are using
> > it for different i2s controller. Below are the details for that.
> >
> > case 1: I2S controller-1: with playback and capture capability
> > case 2: I2S controller-2: with playback capability only
> > case 3: I2S controller-3: with capture capability only.
> >
> > We are registering all the I2S controller with there respective capability.
> >
> > In command 'aplay -l' or 'cat /proc/asound/pcm', among playback devices,
> > capture device is also listed. This is true in case-1 but for case-2 and
> > case-3 also it is showing the same behavior. According to my
> > understanding it should not show the list of all devices i.e. in case of
> > controller having playback capability it should show only playback
> > devices not capture devices and vice versa. Please correct me if I am
> > wrong.
> >
> > So my questions are
> > 1. How to separate playback and capture devices in case-2 and case-3.
> > Are we need to register different codec for different i2s controller?
How asoc builds this is based on dailinks you have provided. If for the
device 2 and device 3 the cpu and codec dais support both playback and
capture devices, it will go ahead and register these device.
The fact that for device 2 and device 3 capture is also registered
suggests me that your cpu dais are not correct.

Would help if you post your code, esp the codec, cpu dais and dialinks.

-- 
~Vinod
