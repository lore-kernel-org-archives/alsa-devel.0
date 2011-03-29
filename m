From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/2] sound: asoc: Adding support for
	SPEAr13XX ASoC driver
Date: Tue, 29 Mar 2011 12:24:21 +0530
Message-ID: <4D91821D.5030300@st.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317150539.GF31411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DFC824179
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 08:58:27 +0200 (CEST)
In-Reply-To: <20110317150539.GF31411@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark
   
On 3/17/2011 8:35 PM, Mark Brown wrote:
> On Thu, Mar 17, 2011 at 04:53:35PM +0530, Rajeev Kumar wrote:
> 
>> > This patch contains the following support as per the ASoC framework:
>> > 1. Platform Driver (I2S based).
>> > 2. Machine Driver.
> These should be split into separate patches...
> 
Before sending patches for audio support on spear platform, need to confirm about how to split into patches.
Files I have 

1. sound/soc/spear/Kconfig
2. sound/soc/spear/Makefile
3. sound/soc/spear/evb_sta529.c
4. sound/soc/spear/spear13xx-i2s.c
5. sound/soc/spear/spear13xx-i2s.h
6. sound/soc/spear/spear13xx-pcm.c
7. sound/soc/spear/spear13xx-pcm.h

Could you please let me know where to put these Kconfig and Makefile either in platform driver or in m/c driver

Best Rgds
Rajeev

>> > The codec driver for STA529 is present in a separate patch.
