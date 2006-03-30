From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS emulation question
Date: Thu, 30 Mar 2006 14:55:59 +0200
Message-ID: <20060330125559.GC12081@turing.informatik.uni-halle.de>
References: <1143673730.15278.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1143673730.15278.7.camel@localhost.localdomain>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> My mixer code is currently not working because my device does not report
> the availability of SOUND_MASK_VOLUME to the oss emulation code.

ALSA's OSS emulation automatically computed the mask value.

> In the olden days I'd just write the ioctl - presumably I don't have to
> do that with ALSA? How do I get round it?

See snd_mixer_oss_build() in core/oss/mixer_oss.c for a list of mixer
control names that get mapped to OSS controls (e.g., "Master Playback
Volume"/"...Switch" would be mapped to SOUND_MIXER_VOLUME).


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
