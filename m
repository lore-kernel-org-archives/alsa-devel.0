From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 20 May 2010 09:34:21 +0200
Message-ID: <4BF4E5FD.2040808@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 0109F1039A0
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 09:34:58 +0200 (CEST)
In-Reply-To: <201005191834.57919.vand2@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sebastian H. wrote:
> Is there always an 1 to 1 mapping from volume to decibel and vice 
> versa or can there be decibel values in between two volume steps?

The volume values are the device's hardware register values and could
have any random dB difference between steps (and that difference might
not even be constant over the entire range).  The volume/dB mapping just
tells you which dB or volume value is nearest to a given volume or
dB value.


Regards,
Clemens
