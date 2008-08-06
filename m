From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Wed, 6 Aug 2008 10:26:00 +0100
Message-ID: <20080806092559.GA26169@sirena.org.uk>
References: <20080804121221.GC2499@sirena.org.uk>
	<13184.28411.qm@web50106.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E51B52476F
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 11:26:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <13184.28411.qm@web50106.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 05, 2008 at 08:06:06PM -0700, Nitin Mahajan wrote:

> Here is the mixer-config file got through 'alsactl'. Could you please guide me which controls to set with what values using amixer, for playback through Headphone and Recording?

For playback try these:

> 	control.4 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		comment.count 1
> 		iface MIXER
> 		name 'Headphone Playback Switch'
> 		value false
> 	}

This should be enabled.

> 	control.8 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		comment.count 1
> 		iface MIXER
> 		name 'Headphone Playback ZC Switch'
> 		value false
> 	}

It's better to enable this but not essential - it avoids audio artifacts
while doing volume updates during playback.

> 	control.64 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		comment.count 1
> 		iface MIXER
> 		name 'Right Mixer PCM Playback Switch'
> 		value false
> 	}
> 	control.65 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		comment.count 1
> 		iface MIXER
> 		name 'Left Mixer PCM Playback Switch'
> 		value false
> 	}

These should be enabled.

If this still gives you trouble then please build with DAPM_DEBUG
enabled in soc-dapm.c (or #define DEBUG at very the top of the file
prior to the includes if using a very current version).  This will cause
ASoC to produce debug output when it starts playback which should show
anything that needs to be enabled but isn't.

Please also make sure that you are using a driver with the patch that
Marek identified earlier in the thread.
