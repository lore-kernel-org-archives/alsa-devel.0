From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Tue, 30 Aug 2011 09:40:23 +0200
Message-ID: <4E5C93E7.9010804@ladisch.de>
References: <4E53C32E.9020801@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>	<4E5483CD.6070808@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>	<4E55F634.9070601@canonical.com>	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>	<4E56C088.6080402@canonical.com>
	<1314656063.27660.9.camel@plb-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 25EC824518
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 09:40:20 +0200 (CEST)
In-Reply-To: <1314656063.27660.9.camel@plb-Dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> User-space code will need at some point to rely on the ELD information
> to know what the HDMI receiver supports, eg to enable/disable
> passthrough. I hacked a while ago a small patch to make the ELD bytes
> available in a control (see attached). It seems to work but I wasn't too
> sure how to expose it.

For something device-specific as this, a _BYTES control is the only
choice.  An alternative would be to have one control for each field in
the ELD.

If the driver can detect ELD changes, it must inform userspace that
the control has changed.  If there is no ELD, the _get callback should
return an error, and the control should have been set to unreadable.

> Should we define a convention for the name of this control as well?

If software is supposed to be able to find this control for any HDMI
device.

> Or is there a way to link a control to a specify PCM device?

Yes: set .iface to _PCM instead of _MIXER (this will also prevent
'normal' mixers from showing this control, but a _BYTE control wouldn't
be shown anyway), and set .device (and .subdevice, if appropriate) to
the PCM device's (sub)device number.


Regards,
Clemens
