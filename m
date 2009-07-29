From: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Subject: Re: Using Alsa for AD1981b on 9263
Date: Wed, 29 Jul 2009 13:01:18 +0530
Message-ID: <33A0EEB8D50198449794A1AB9DEB1E01866417CB9C@copuex01.coreobjects.com>
References: <33A0EEB8D50198449794A1AB9DEB1E01866417CA0C@copuex01.coreobjects.com>
	<20090728113906.GC26452@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from colaex01.coreobjects.com (mailus.coreobjects.com [67.89.120.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 18520103853
	for <Alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 09:33:13 +0200 (CEST)
In-Reply-To: <20090728113906.GC26452@sirena.org.uk>
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
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I built the alsa lib with " --without-versioned". But still if I give aplay -l, I get following:

# aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:2700:(snd_config_hooks_call) Cannot open shared library (null)
ALSA lib conf.c:3079:(snd_config_update_r) hooks failed, removing configuration
aplay: device_list:232: control open (0): No such file or directory

Atmel is not responding for this issue. I have already placed a query on Atmel forum as well. But no reply from there.


Thanks & Regards,
--Shilpa.


-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
Sent: Tuesday, July 28, 2009 5:09 PM
To: Shilpa Kedar Walvekar
Cc: Alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Using Alsa for AD1981b on 9263

On Tue, Jul 28, 2009 at 04:59:12PM +0530, Shilpa Kedar Walvekar wrote:

> **** List of PLAYBACK Hardware Devices ****
> ALSA lib conf.c:2700:(snd_config_hooks_call) Cannot open shared library (null)
> ALSA lib conf.c:3079:(snd_config_update_r) hooks failed, removing configuration
> aplay: device_list:232: control open (0): No such file or directory

> We are not able to get if module is getting loaded, then why aplay doesn't list the device?

> Please help us to get the audio codec working.

This is a toolchain problem.  Normally it's that the uclibc toolchain
Atmel use by default doesn't support symbol versioning which means you
have to pass a configure option to ALSA to disable symbol versioning but
you're likely to get better help from an Atmel-specific place.
