From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [RFC] A question regarding open ioctl for user space
	in ASoC driver.
Date: Fri, 16 May 2014 18:59:41 +0800
Message-ID: <20140516105939.GA2544@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 by alsa0.perex.cz (Postfix) with ESMTP id 80EED261A12
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 13:17:06 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I have an ASoC driver in my own branch and I'm going to get it upstream
in the months ahead. The driver is designed for Freescale ASRC module,
Asynchronous Sample Rate Converter. It has the capability to convert audio
data without involving software conversion like SRC function in ALSA-lib.
But before I try to revise and send the driver, I've a few questions here.

We currently have two main functions for ASRC: P2P's and M2M's.

1) P2P, peripheral to peripheral, regards ASRC as a FE (front end link)
   corresponding to a BE (back end link like ESAI<->CS42888). The P2P
   function resolves a problem of unsupported sample rates for BE that
   we can convert the unsupported audio format to a supported one before
   we send the data into BE. It also has better quality and less CPU
   loading comparing to ALSA-lib's SRC function.

   * For this function, I don't see any critical problem here. But...

2) M2M, memory to memory, can simply make ASRC as a sample rate converter
   without playback via any BE sound card, just like using any software
   to convert a WAV file in one sample rate to another WAV in a required
   sample rate. The driver has its self-designed application to compelte
   this function by sending the audio data from a wave file into a misc
   device via non-generic ioctl:

static long asrc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	struct asrc_pair_params *params = file->private_data;
	void __user *user = (void __user *)arg;
	long ret = 0;

	switch (cmd) {
	case ASRC_REQ_PAIR:
		ret = asrc_ioctl_req_pair(params, user);
		break;
	case ASRC_CONFIG_PAIR:
		ret = asrc_ioctl_config_pair(params, user);
		break;
	case ASRC_START_CONV:
	[...]

So I'm wondering if this kind of ioctl would be allowed or there's any
alternative approach?

Not only having application in user space, but we also have an ASRC
plugin for ALSA-lib so that it can involve M2M function by using the
plugin before sending data via pcm_write().

And here's the another question -- to share the ioctl and the struct
asrc_pair_params with user space, there's a header file need to be
put into include/uapi/. Is it possible?

There's a reference code (drivers/mxc/asrc/mxc_asrc.c) located in:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/?h=imx_3.10.17_1.0.0_ga

In our internal branch, the ASRC driver currently is divided into two
drivers for M2M and P2P separately. For upstream version, I'm trying
to merge them into a single ASoC driver with both M2M and P2P, just
not sure how to handle the M2M part appropriately.

Thank you,
Nicolin Chen
