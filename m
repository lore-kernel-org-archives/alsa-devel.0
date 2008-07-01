From: "Mitul Sen (misen)" <misen@cisco.com>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
	let	me apply hardware parameters
Date: Tue, 1 Jul 2008 10:01:04 -0700
Message-ID: <3B6F5C9068D5864096EB291236C3386F02CE162C@xmb-sjc-21d.amer.cisco.com>
References: <4869DF2F.8090609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	by alsa0.perex.cz (Postfix) with ESMTP id BEA4924414
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 19:01:17 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <4869DF2F.8090609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The code is correct (as intended). I am sorry I forgot to change the
comment. I think I should be using SND_PCM_ACCESS_RW_NONINTERLEAVED
since I have only one source (mono). Please correct me if that is wrong.

Regards,
Mitul 

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Clemens
Ladisch
Sent: Tuesday, July 01, 2008 12:39 AM
To: Mitul Sen (misen)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Setting format to SND_PCM_FORMAT_MU_LAW does
not let me apply hardware parameters

Mitul Sen (misen) wrote:
> // Set access to RW interleaved.
> if ((err = snd_pcm_hw_params_set_access (_soundDevice, hw_params,
> SND_PCM_ACCESS_RW_NONINTERLEAVED)) < 0)

The comment and the code do not agree.  Please try
SND_PCM_ACCESS_RW_INTERLEAVED.


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
