From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [PATCH v3 2/3] ECI: introducing ECI bus driver
Date: Wed, 05 Jan 2011 10:21:07 +0200
Message-ID: <4D2429F3.80004@nokia.com>
References: <1294149748-13854-1-git-send-email-tapio.vihuri@nokia.com>	<1294149748-13854-2-git-send-email-tapio.vihuri@nokia.com> <1294149748-13854-3-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294149748-13854-3-git-send-email-tapio.vihuri@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext tapio.vihuri@nokia.com" <tapio.vihuri@nokia.com>
Cc: dmitry.torokhov@gmail.com, randy.dunlap@oracle.com, alsa-devel@alsa-project.org, ilkka.koskinen@nokia.com, linux-kernel@vger.kernel.org, samu.p.onkalo@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 01/04/11 16:02, ext tapio.vihuri@nokia.com wrote:
> From: Tapio Vihuri <tapio.vihuri@nokia.com>
>=20
> ECI bus controller is kind of bridge between host CPU I2C and ECI acc=
essory
> ECI communication.

There seams to be no change between v2 and v3 in regards to this micro
controller driver, so my comments on the v2 applies here as well.

Would you rename the driver (to something other than ecibus)?
If the intention is to make this driver only work on Intel's Moorestown
platform, then be it, but you should mention it explicitly in the
Kconfig, and the driver name shall reflect the same as well.

My comments on the intel specific intel_scu_ipc_iowrite8, and the i2c
part still holds.

Thanks,
P=E9ter
