From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 19:01:52 +0200
Message-ID: <4E4BF400.9010707@ladisch.de>
References: <1313567970.533.21.camel@snowflake> <4E4BB74C.40302@ladisch.de>
	<1313586408.533.30.camel@snowflake>
	<000901cc5cf2$af7fa180$0e7ee480$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 79A30243DF
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 19:01:57 +0200 (CEST)
In-Reply-To: <000901cc5cf2$af7fa180$0e7ee480$@bossart@linux.intel.com>
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
Cc: 'Arun Raghavan' <arun.raghavan@collabora.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> If you try to set the bits with ALSA controls in PulseAudio, somehow the
> settings are overwritten when the iec958 device is opened and initialized
> with default values.

That's how the iec958 device is intended to work.

The AES0..3 parameters of the iec958 device are the _only_ way to set
these flags.  If you don't set them, they get a static default value;
see <http://git.alsa-project.org/?p=alsa-lib.git;a=blob;hb=HEAD;f=src/conf/pcm/iec958.conf>.

If PA wants to set these flags, it must do so when opening the device;
any other mechanism will not work.


Regards,
Clemens
