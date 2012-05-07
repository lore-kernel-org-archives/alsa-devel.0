From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 1/1] ALSA: hdsp - Provide ioctl_compat
Date: Mon, 7 May 2012 18:55:04 +0200
Message-ID: <20120507165504.GY6396@ltw.loris.tv>
References: <1336152952-21309-1-git-send-email-andre.schramm@iosono-sound.com>
	<1336409571-13371-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1336409571-13371-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 07, 2012 at 06:52:51PM +0200, Adrian Knoth wrote:

> From: Andre Schramm <andre.schramm@iosono-sound.com>
> 
> snd_hdsp uses its own ioctls to acquire config- and status information.
> Expose the corresponding ioctl handler via ioctl_compat, so that 32bit applications can use it on 64bit kernels.
> 
> Signed-off-by: Andre Schramm <andre.schramm@iosono-sound.com>
> Reviewed-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

The last line wasn't supposed to be there, feel free to drop it.

Sorry for the noise, copy&paste error.


Mea culpa

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
