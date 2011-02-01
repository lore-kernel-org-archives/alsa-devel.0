From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 0/3] input: Add support for ECI
 (multimedia) accessories
Date: Tue, 1 Feb 2011 00:58:23 -0800
Message-ID: <20110201085823.GB17706@core.coreip.homeip.net>
References: <1296482634-31666-1-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E62E2443F
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 09:58:34 +0100 (CET)
Received: by iwb12 with SMTP id 12so6925691iwb.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 00:58:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296482634-31666-1-git-send-email-tapio.vihuri@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tapio.vihuri@nokia.com
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi Tapio,

On Mon, Jan 31, 2011 at 04:03:51PM +0200, tapio.vihuri@nokia.com wrote:
> 
> This patch set introduce Multimedia Headset Accessory support for
> Nokia phones. Technically those are known as ECI (Enhancement Control Interface)
> 	
> If headset has many buttons, like play, vol+, vol- etc. then it is propably ECI
> accessory.
> 
> Among several buttons ECI accessories contains memory for storing several
> parameters.
> 
> This ECI input driver provides the following features:
>  - reading ECI configuration memory
>  - ECI buttons as input events
> 
> Drive is constructed as follows:
>  - ECI accessory input driver deals with headset accessory
>  - ECI bus control driver deals the HW transfering data to/from headset
>  - platform data match used HW

I finally had a chance to look though the patches more closely and I do
not understand why you decided to introduce the platform device in
addition to I2C device. You end up with 2 artificially separated bodies of
code that are not viable on their own. The ECI module with it's platform
device is not usable without the controller; the controller can not be
registered without the ECI device initialized; there are ordering
issues, both initialization and PM-wise and you are forced to support
only one device.

Is there going to be an SPI interface as well? If not then fold it all
together and have I2C device as the only device involved. If SPI is a
possibility then look in drivers such as adxl34x, ad714x and others that
are split into core module and bus interface implementations.

Thanks.

-- 
Dmitry
