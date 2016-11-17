From: Norbert Preining <preining@logic.at>
Subject: Re: Lenovo Dock + Thinkpad X260 -> no HDMI audio output
Date: Thu, 17 Nov 2016 11:50:50 +0900
Message-ID: <20161117025050.namubp3tzsg2ipbk@burischnitzel.preining.info>
References: <20161116023821.hcwg4u2iconuc5d6@burischnitzel.preining.info>
 <20161116120753.4wuw5feaoklqajf5@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161116120753.4wuw5feaoklqajf5@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sebastian,

> Lenovo Dock Ultra contains a DP-MST Hub to provide all those
> HDMI/DVI/DP ports. Audio over DP-MST is currently not supported
> by the i915 driver, but there are patches (developed since ~2014):
> 
> https://lists.freedesktop.org/archives/intel-gfx/2016-November/111353.html

Thanks a lot. I have tried out the patch including possible fixes for the
monitor disconnect issues mentioned in the freedesktop bug, but it does
not fix the problem of the disappearing external monitor.

Well, that means no audio-out for now, unfortunately. I will have to live
without that.

Thanks

Norbert

--
PREINING Norbert + TeX Live & Debian Developer + http://www.preining.info
GPG: 0x860CDC13    fp: F7D8 A928 26E3 16A1 9FA0  ACF0 6CAC A448 860C DC13
