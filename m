From: Julien Cristau <jcristau@debian.org>
Subject: Re: [alsa-devel] No mixers on ATI RS780 Azalia
Date: Mon, 7 Jun 2010 21:24:11 +0200
Message-ID: <20100607192411.GV3043@radis.liafa.jussieu.fr>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
	<s5hmxvmzwwd.wl%tiwai@suse.de>
	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>
	<4BFD2901.20800@ladisch.de>
	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
	<4BFE5AA1.7070103@ladisch.de> <4BFE66CA.5070400@ladisch.de>
	<alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun  7, 2010 at 14:49:16 +0200, Jan Engelhardt wrote:

> * The radeon.ko module does not have any PCI IDs defined, thus does not 
> get autoloaded like i915.ko. Is this intentional? It also seems
> to default to modeset=0.

It only defines PCI IDs (and gets autoloaded) if CONFIG_DRM_RADEON_KMS=y.

Cheers,
Julien
