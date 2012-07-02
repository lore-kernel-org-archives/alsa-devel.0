From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 24 bit sample embedded in 32 bits
Date: Mon, 02 Jul 2012 13:02:49 +0200
Message-ID: <4FF17FD9.8040409@perex.cz>
References: <4FF173D4.7060401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id C644C2455B
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 13:01:11 +0200 (CEST)
In-Reply-To: <4FF173D4.7060401@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vipin.kumar@st.com
List-Id: alsa-devel@alsa-project.org

Date 2.7.2012 12:11, Vipin Kumar wrote:
> Hello,
> 
> I assume that the alsa framework expects the 24 bit sample data to be 
> packed one after the other. for example while recording a 2 channel, 24 
> bit sample data, typically the dma reads a fifo (which receives data 
> from adc) and prepares a buffer which is then passed to the upper layers.
> 
> This buffer is expeted to be 24byte left channel and then 24 byte right 
> channel. Am I right?
> 
> If the above assumption is correct, I need to find a way to tell the 
> framework that the data is 24bit but is embedded in 32 bit. ie 32bit 
> left and then 32 bit right channel data
> 
> I am tending to think that there has to be a way but I am unable to find 
> it. Can you please point me to the right direction

Use S/U24 or S/U32 formats - look to adriver.h for SNDRV_PCM_FORMAT
constants. S/U24 expects 24-bit samples with zero MSB in 32-bit words.
S/U32 expects 32-bit samples (LSB is zero for 24-bit data).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
