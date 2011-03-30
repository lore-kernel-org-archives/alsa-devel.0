From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 3/5] sound: asoc: Adding support for
 SPEAr13XX ASoC machine driver
Date: Wed, 30 Mar 2011 10:25:07 +0530
Message-ID: <4D92B7AB.4010907@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
	<20110329233219.GL30482@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B450103813
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 06:57:56 +0200 (CEST)
In-Reply-To: <20110329233219.GL30482@opensource.wolfsonmicro.com>
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

On 3/30/2011 5:02 AM, Mark Brown wrote:
> On Tue, Mar 29, 2011 at 04:47:01PM +0530, Rajeev Kumar wrote:
> 
>> +	/* Create and register platform device */
>> +	evb_snd_device = platform_device_alloc("soc-audio", 0);
>> +	if (!evb_snd_device) {
>> +		printk(KERN_ERR "platform_device_alloc fails\n");
>> +		return -ENOMEM;
>> +	}
> 
> It's better to use snd_soc_register_card() rather than using the
> soc-audio device with current kernels
>
This patch set has been compiled and tested for Linux-kernel-version 2.6.38,since SPEAr 
patch is already under review in russel king branch. 
Once it is ported I will circulate the next patch set containing these specific changes.

Best Rgds
Rajeev
