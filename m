From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Tue, 30 Aug 2011 09:06:37 +0200
Message-ID: <4E5C8BFD.3070809@canonical.com>
References: <4E53C32E.9020801@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
	<4E5483CD.6070808@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>
	<4E55F634.9070601@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>
	<4E56C088.6080402@canonical.com>
	<1314656063.27660.9.camel@plb-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 7F982244E6
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 09:06:45 +0200 (CEST)
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

On 08/30/2011 12:14 AM, Pierre-Louis Bossart wrote:
>
>> Since modern HDMI cards often have more than one output pin and thus
>> input device, we need to know which one has actually been plugged in.
>> This patch adds a name hint that indicates which PCM device is connected
>> to which pin.
>
> I've been thinking about this, and there's some additional work needed
> for the jack-detection to be useful.
> User-space code will need at some point to rely on the ELD information
> to know what the HDMI receiver supports, eg to enable/disable
> passthrough.

Meanwhile, at the PulseAudio side, Colin (and Arun?) have made it 
possible to set capabilities manually in PulseAudio, based on the 
assumption that the ELD information is often wrong anyway. (?)

> I hacked a while ago a small patch to make the ELD bytes
> available in a control (see attached). It seems to work but I wasn't too
> sure how to expose it.

I'm assuming that if you have four HDMI pins (or codecs) that will be 
four "ELD Bytes" controls?

Also, are we sure we want to expose something as driver specific as ELD 
bytes through that interface, or do we want to do something more 
generic? (That said, exposing ELD bytes could also be an interim 
solution while thinking about something more generic.)

> Should we define a convention for the name of this control as well?

Note that my patch doesn't change the name of a control but an input device.

> Or is there a way to link a control to a specify PCM device?

Unfortunately not - maybe this is something to discuss at Linuxcon Prague?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
