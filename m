From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Ensoniq SoundScape VIVO90
Date: Fri, 14 Sep 2007 17:06:55 +0100 (BST)
Message-ID: <44760.17962.qm@web52902.mail.re2.yahoo.com>
References: <46EAADFD.20304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52902.mail.re2.yahoo.com (web52902.mail.re2.yahoo.com
	[206.190.49.12]) by alsa0.perex.cz (Postfix) with SMTP id 2F464244F8
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 18:06:57 +0200 (CEST)
In-Reply-To: <46EAADFD.20304@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--- Rene Herman <rene.herman@gmail.com> wrote:
> On 09/14/2007 05:17 PM, Chris Rankin wrote:
> > I naturally tested this driver with the only Ensoniq SoundScape card that
> > I owned (the PnP version), and yes, it works. All I did was convert as
> > much of the original OSS driver to ALSA as I could verify.
> 
> Great, thanks for the answer. The 3081 is a little different resource wise 
> then. It finds the codec at "mpu_port" + 8, whereas the VIVOs (4081) has it 
> as a seperate PnP resource.
> 
> 3081:	Soundscape/MPU	port = pnp_port(0),	irq = pnp_irq(1)
> 	Codec		port = + 8,		irq = pnp_irq(0)
> 
> 4081:	Soundscape/MPU	port = pnp_port(0),	irq = pnp_irq(1)
> 	Codec		port = pnp_port(1),	irq = pnp_irq(0)
> 
> It's possible to switch behaviour on the PnP ID (for example by setting 
> pnp_card_device_id->driver_data in the ID table).

Do you have the old OSS SoundScape driver code, and did it support the VIVO? I seem to recall that
there were several extra code-paths in there for other SoundScape versions.

Cheers,
Chris



      _______________________________________________________
Try Yahoo! Mail now with Unlimited Storage and see the difference.
http://uk.mail.yahoo.com
