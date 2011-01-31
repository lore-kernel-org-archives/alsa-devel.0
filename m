From: Stephen Warren <swarren@nvidia.com>
Subject: Re: NVIDIA HDMI surround sound is broken starting
	with	kernel 2.6.36
Date: Mon, 31 Jan 2011 09:51:20 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E1CB@HQMAIL01.nvidia.com>
References: <AANLkTikFWjahA8TcGzTuWjkvkvg4chA0Q7s-1nXj179e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C7E24661
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 18:51:28 +0100 (CET)
In-Reply-To: <AANLkTikFWjahA8TcGzTuWjkvkvg4chA0Q7s-1nXj179e@mail.gmail.com>
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
To: VDR User <user.vdr@gmail.com>, "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

VDR User wrote at Monday, January 31, 2011 10:39 AM:
> ...
> Also, even though the eld file is removed, the eld info is _not_
> updated when stopping alsa & unloading drivers, then reloading.  A
> reboot is required to get the eld info to update.  This is why I cold
> boot the pc for each test.

The NVIDIA graphics driver reads the monitor's EDID and passed the ELD
information to the audio HW, from whence it is read by the ALSA driver.
The EDID is only read when the X server is started, or perhaps when you
click the "detect displays" button in the nvidia-settings utility.

Hence, restarting X (e.g. logout/login), or using nvidia-settings, is
probably sufficient to update the ELD data; no reboot required.

Hope this helps.

-- 
nvpublic
