From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 21:11:02 +0530
Message-ID: <1313595697.533.32.camel@snowflake>
References: <1313567970.533.21.camel@snowflake> <4E4BB74C.40302@ladisch.de>
	<1313586408.533.30.camel@snowflake> <4E4BD67F.1060509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 76B0F24377
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 17:40:27 +0200 (CEST)
In-Reply-To: <4E4BD67F.1060509@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-08-17 at 16:55 +0200, Clemens Ladisch wrote:
> Arun Raghavan wrote:
> > On Wed, 2011-08-17 at 14:42 +0200, Clemens Ladisch wrote:
> > > Arun Raghavan wrote:
> > > > I'm trying to figure out the right way to set the NONAUDIO flag on an
> > > > iec958 device.
> > > 
> > > Use the device name "iec958:AES0=6".
> > 
> > Thanks. As I understand it, this forces us to set all the flags instead
> > of just the one that we're interested in.
> 
> Yes.  However, using 'default' values for these other flags would not
> make much sense because your application is the only one that knows the
> correct values.
> 
> > Is this the only way?
> 
> It's the only portable way.
> 

Got it -- thanks for the help!

-- Arun
