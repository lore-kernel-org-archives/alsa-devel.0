From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] sound: Don't assume i2c device probing
	always succeeds
Date: Wed, 30 Sep 2009 17:57:44 +0200
Message-ID: <20090930175744.2ad791d3@hyperion.delvare>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
	<20090930170006.76e145ca@hyperion.delvare>
	<1254323111.3959.6.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by alsa0.perex.cz (Postfix) with ESMTP id A553A24433
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 17:57:46 +0200 (CEST)
In-Reply-To: <1254323111.3959.6.camel@johannes.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>, Tim@alsa-project.org, Shepard <shep@alum.mit.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Sep 2009 17:05:11 +0200, Johannes Berg wrote:
> On Wed, 2009-09-30 at 17:00 +0200, Jean Delvare wrote:
> 
> > The NULL check of client->driver, if followed by a call to
> > i2c_unregister_device(), would indeed be enough. But unlike the onyx
> > driver which we know we sometimes load erroneously, the other drivers
> > should never fail.
> 
> All of these drivers can be loaded manually and then fail though, or am
> I misunderstanding something?

I don't think so. At least tas and keywest have checks before they
attempt to instantiate an i2c client, which I think are reliable. The
onyx case is different because apparently some machines have it but are
difficult to detect:

	/* if that didn't work, try desperate mode for older
	 * machines that have stuff missing from the device tree */

And then we have to attempt to instantiate i2c devices at a not
completely known address, and that may fail. I think this is the reason
why onyx has this extra client->driver NULL check and the other two
drivers do not.

I would really love if someone with good knowledge of the device tree
on mac would convert all these hacks to proper i2c device declarations.
All the infrastructure is available already, but I don't know enough
about open firmware and mac the device tree to do it myself.

-- 
Jean Delvare
