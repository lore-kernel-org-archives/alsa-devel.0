From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using Alsa for AD1981b on 9263
Date: Tue, 28 Jul 2009 12:39:07 +0100
Message-ID: <20090728113906.GC26452@sirena.org.uk>
References: <33A0EEB8D50198449794A1AB9DEB1E01866417CA0C@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F3CB10381A
	for <Alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 13:39:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <33A0EEB8D50198449794A1AB9DEB1E01866417CA0C@copuex01.coreobjects.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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
