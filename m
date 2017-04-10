From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: Add support for Conexant
 CX2092X DSP
Date: Tue, 11 Apr 2017 03:43:40 +0800
Message-ID: <20170410194340.GA2245@GMAIL.COM>
References: <cover.1491446448.git.simon.ho@conexant.com>
 <1e118d265847bf96722b8898ee11891c047558c6.1491446448.git.simon.ho@conexant.com>
 <20170407113737.wp676mcrpeqwno72@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C86F266C13
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 21:43:47 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id o126so10283199pfb.1
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 12:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170407113737.wp676mcrpeqwno72@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 07, 2017 at 12:37:37PM +0100, Mark Brown wrote:
> On Thu, Apr 06, 2017 at 11:04:34AM +0800, simon.ho.cnxt@gmail.com wrote:
> > From: Simon Ho <simon.ho@conexant.com>
> > 
> > Initial commit of Conexant CX20921/CX20924 I2S Audio DSP driver
> > 
> > The CX2092X devices are designed for virtual assisant application need to
> > be always open, listening for users to summon it. There is no any power
> > saving mode support on this device. The processed voice data will be sent
> > to automatic speech recognition (ASR) application for further processing.

> 
> This is still fundamentally just passing undocumented commands straight
> through to the device (presumably to a firmware flashed onto the device
> since there's not even a firmware download happening) without any
> substantial integration with the rest of the system.  That still doesn't
> really feel like a Linux driver at all, it seems more like it's just
> punching a hole through the Linux driver stack for proprietary software
> to do its thing.  I'm also not clear how this can even implement always
> on speech recognition, there seems to be no interrupt support which I'd
> have thought would be a requirement.
> 

Thanks for review and Yes, there is a SPI memory for firmware and 
platform-specific configuration. The device can load and apply 
confguration automatically upon device is power on. No configuration 
is needed from driver side.

The purpose of the tunnel interface are for debugng and tunning purpose.
The manufactor can use the them to customized the firmware to suit their
needs. furtherore, the commands are platform specific and also firmware
version specific. So that it is impossible to provide such commands in 
kernel unless we change our firmware design and policy.

The device have GPIO pin can be configured as interrupt out pin, this 
feaures is option, not a must for SR application actually. In addition,
I think the interrupt is platfrom-specpfic should be configured by 
Machine driver, am I right? 

> There are other vendors with voice processing features, the drivers for
> all these devices should be presenting interfaces that look similar to
> each other.  What those drivers doing treaming the speech data to the
> host via a normal PCM which blocks while there's no speech data, that is
> much better integrated than this.
> 
> You really need to address this, a big part of how Linux has got to
> where it is today is that it doesn't just have custom interfaces for
> each device but instead generalizes things so that we share good
> practice and features between devices and users can write Linux
> applications rather than vendor specific applications.

Just like DMic, I imagine. The DMIC is not configurable, but it still
requires a driver to communicate with the reset of the system. This
won't prevent people from developing the application for DMIC to extend
its functionality. 

The device send the normal PCM data to host as it claimed by codec
driver, and we confirmed that the device can work with most SR 
software without problem.  
