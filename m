From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Tue, 3 Aug 2010 18:10:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008031809520.4068@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9599424506
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:10:53 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: 'alsa-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Aug 2010, Stephen Warren wrote:

> A user has the following setup:
>
> A GPU which supports audio-over-HDMI. The codec supports sample rates 
> 32000 44100 48000 88200 96000 176400 192000 (from 
> /proc/asound/card1/codec#1). However, the user's TV supports only sample 
> rates 44100 48000 88200 (from /proc/asound/card1/eld*).
>
> When the user plays sound with sample rate 22050, they hear nothing. 
> Sound with sample rates supported by the TV works OK.
>
> My question: Is the HDA codec driver supposed to dynamically adjust its 
> list of supported sample rates based on the ELD content, or is the ALSA 
> library somehow supposed to detect the subset of rates supported in HW 
> and convert the sample rate in SW before sending the audio to the 
> driver?

The driver must return the correct list of supported sample rates. 
Otherwise alsa-lib thinks that the invalid sample rate is supported in the 
hardware or driver.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
