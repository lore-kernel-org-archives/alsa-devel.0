From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 16:55:59 +0200
Message-ID: <4E4BD67F.1060509@ladisch.de>
References: <1313567970.533.21.camel@snowflake> <4E4BB74C.40302@ladisch.de>
	<1313586408.533.30.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 894C72432E
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 16:56:06 +0200 (CEST)
In-Reply-To: <1313586408.533.30.camel@snowflake>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Arun Raghavan wrote:
> On Wed, 2011-08-17 at 14:42 +0200, Clemens Ladisch wrote:
> > Arun Raghavan wrote:
> > > I'm trying to figure out the right way to set the NONAUDIO flag on an
> > > iec958 device.
> > 
> > Use the device name "iec958:AES0=6".
> 
> Thanks. As I understand it, this forces us to set all the flags instead
> of just the one that we're interested in.

Yes.  However, using 'default' values for these other flags would not
make much sense because your application is the only one that knows the
correct values.

> Is this the only way?

It's the only portable way.


Regards,
Clemens
