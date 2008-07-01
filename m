From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Tue, 01 Jul 2008 09:39:27 +0200
Message-ID: <4869DF2F.8090609@ladisch.de>
References: <3B6F5C9068D5864096EB291236C3386F02CE1628@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D7CB92481E
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 09:39:30 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F02CE1628@xmb-sjc-21d.amer.cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mitul Sen (misen)" <misen@cisco.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mitul Sen (misen) wrote:
> // Set access to RW interleaved.
> if ((err = snd_pcm_hw_params_set_access (_soundDevice, hw_params,
> SND_PCM_ACCESS_RW_NONINTERLEAVED)) < 0)

The comment and the code do not agree.  Please try
SND_PCM_ACCESS_RW_INTERLEAVED.


Regards,
Clemens
