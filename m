From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to handle parameter variation across different
	boards but same platform
Date: Thu, 5 Jul 2012 08:32:16 +0000
Message-ID: <201207050832.16750.arnd@arndb.de>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704142745.GC4111@opensource.wolfsonmicro.com>
	<4FF52948.6090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E520B243C5
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 10:32:44 +0200 (CEST)
In-Reply-To: <4FF52948.6090904@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Vaibhav Hiremath <hvaibhav@ti.com>, "Hebbar,
	Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 05 July 2012, Vaibhav Hiremath wrote:
> On 7/4/2012 7:57 PM, Mark Brown wrote:
> > On Wed, Jul 04, 2012 at 02:17:48PM +0000, Hebbar, Gururaja wrote:
> >> On Wed, Jul 04, 2012 at 19:31:18, Mark Brown wrote:
> > 
> >>> If these are totally different boards they should have different machine
> >>> IDs set so machine_is_() should identify.  If that isn't there then you
> >>> need to do something custom to your products to identify the boards
> >>> further.
> > 
> >> They are different boards with same SoC (AM33xx). So they both are true for
> >> machine_is_am33xx().
> > 
> 
> What if the device only supports Linux boot from DT, where we set
> machine_desc.nr = ~0 ??
> 
> Does machine ID still gets set? May be I am missing something...

No, it doesn't.

> As part of my debugging, on AM335xEVM platform machine_is_am33xx()
> returns false, since the value of machine_desc.nr is set to ~0.

Correct. However, when you are booting using the device tree, parameters
such as the clock frequency of a device should be encoded in the device
tree itself, so you don't need to know which machine you are on.

	Arnd
