From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Fri, 21 May 2010 11:56:22 +0200
Message-ID: <4BF658C6.4030404@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8CA3C1039AD
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 11:56:25 +0200 (CEST)
In-Reply-To: <201005210951.36495.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "Sebastian H." <vand2@gmx.de>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi wrote:
> On Friday 21 May 2010 09:35:31 ext Clemens Ladisch wrote:
> > James Courtier-Dutton wrote:
> > > I believe it could be extended to support a continuous range.
> > > For example, some hardware uses a 32bit value to control the gain.
> > > The mix operation is simply "the_sample" * "the_control_value".
> > > So in this case the hardware has a linear control that can be
> > > considered continuous for our purposes.
> > 
> > Such controls already exist:
> > 
> > $ grep -rl DB_LINEAR sound/
> > ...
> 
> The DB_SCALE also provides linear mapping:
> For example, if the HW volume control has a range 0 .. 100
> In HW these means:
> 0 == -10dB, 1 == -9.8dB, 2 == -9.6dB .. 99 = 9.8dB, 100 = 10dB
> So it is linear.

This is not what is meant by "linear", because dB values are not linear.

DB_LINEAR means that the mixer control value is a multiplier for the
PCM sample value, as James wrote.  A DB_LINEAR mapping has
0 == -infinity dB, full scale == 0 dB, and the mapping between mixer
control values and corresponding dB values it _not_ linear.

TLV_DB_LINEAR_ITEM is a quite misleading name, but it actually means
"dB mapping for a mixer control whose value has a linear effect on the
sound output", _not_ a linear value <-> dB mapping.


Regards,
Clemens
