From: Stephen Warren <swarren@nvidia.com>
Subject: Re: No HDMI audio output,
 nVidia audio not listed in lspci
Date: Thu, 26 May 2011 08:45:57 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A486A8@HQMAIL01.nvidia.com>
References: <BANLkTimybCjUxvTEJZJ_qZZ8y+s7+cHcUg@mail.gmail.com>
	<4DDE2C03.5030607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDF5103AD6
	for <Alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:46:17 +0200 (CEST)
In-Reply-To: <4DDE2C03.5030607@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, Joost Verdoorn <jpverdoorn@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote at Thursday, May 26, 2011 4:32 AM:
> Joost Verdoorn wrote:
> > No HDMI audio output
> 
> Did you try device "hw:0,1"?
> 
> > nVidia audio not listed in lspci
> 
> I'd guess that your GPU does not have a separate audio controller for
> HDMI but uses S/PDIF data as a source, so you actually have to use the
> digital output of the internal HDA device.

Just to confirm, the GPU model Joost has would support audio by SPDIF
rather than via an embedded HDA device. Unfortunately, I'm not very
familiar with that mechanism, so I can't confirm for sure whether it's
supposed to work on that model.

> I don't know if the graphics driver has to enable something for this
> to work.

There might be some setup work required, but I'm not completely sure. I
think we have code for this in place. Simply starting X and sending a
video signal over the port would be enough from an end-user perspective.

-- 
nvpublic
