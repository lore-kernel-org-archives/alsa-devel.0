From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] [RFC]intel_hdmi_audio: interface module
Date: Wed, 24 Nov 2010 10:11:00 +0000
Message-ID: <20101124101100.GC5139@opensource.wolfsonmicro.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
	<20101122135812.GD15156@sirena.org.uk>
	<s5h8w0jnlby.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 969C3103809
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 11:10:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8w0jnlby.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>, ramesh.babu@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 10:05:05AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Mon, Nov 22, 2010 at 07:09:43PM +0530, ramesh.babu@intel.com wrote:

> > > +	intelhaddata = device->device_data;

> > This function doesn't appear to do anything like what either the
> > description or name would suggest?  I'd expect to see some deallocation
> > going on...

> Reading through the code, the construct doesn't seem to allocate any
> private stuff but only standard components, so this callback doesn't
> have to do anything much, I suppose.

To be honest half the issue was the above quoted line - if the function
had been empty I'd have been less concerned (and probably just said to
remove it).
