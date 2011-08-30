From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
	devices and pcm devices
Date: Tue, 30 Aug 2011 08:01:50 -0500
Message-ID: <21828.806345775$1314709327@news.gmane.org>
References: <4E53C32E.9020801@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>	<4E5483CD.6070808@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>	<4E55F634.9070601@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>	<4E56C088.6080402@canonical.com>	<1314656063.27660.9.camel@plb-Dell>
	<4E5C93E7.9010804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 45D8124466
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 15:01:55 +0200 (CEST)
In-Reply-To: <4E5C93E7.9010804@ladisch.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

> If the driver can detect ELD changes, it must inform userspace that
> the control has changed.  If there is no ELD, the _get callback should
> return an error, and the control should have been set to unreadable.

Bear with my ignorance of controls, but how does the driver 'inform
userspace that the control has changed'?

> > Or is there a way to link a control to a specify PCM device?
> 
> Yes: set .iface to _PCM instead of _MIXER (this will also prevent
> 'normal' mixers from showing this control, but a _BYTE control wouldn't
> be shown anyway), and set .device (and .subdevice, if appropriate) to
> the PCM device's (sub)device number.

This is exactly what I wanted, it makes things simpler. Thanks for the
explanation.
-Pierre
