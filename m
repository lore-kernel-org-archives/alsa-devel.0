From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Is calling snd_pcm_sw_params() mandatory ?
Date: Mon, 29 Nov 2010 09:14:49 +0100
Message-ID: <4CF360F9.9040309@ladisch.de>
References: <AANLkTinXD=5sZHdpPOdsrVnhuS629a7VBXwFQvxaU9+c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 71CFC103853
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 09:12:54 +0100 (CET)
In-Reply-To: <AANLkTinXD=5sZHdpPOdsrVnhuS629a7VBXwFQvxaU9+c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Does alsa-lib has any check whether the application had called snd_pcm_sw_params() or
> it provide default values for those software parameters (e.g. start_threshold, stop_threshold)

The internal snd_pcm_sw_params_default() function does this:

	params->tstamp_mode = SND_PCM_TSTAMP_NONE;
	params->period_step = 1;
	params->sleep_min = 0;
	params->avail_min = pcm->period_size;
	params->xfer_align = 1;
	params->start_threshold = 1;
	params->stop_threshold = pcm->buffer_size;
	params->silence_threshold = 0;
	params->silence_size = 0;


Regards,
Clemens
