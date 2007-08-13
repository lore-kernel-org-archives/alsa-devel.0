From: Damon Chaplin <damon@karuna.eclipse.co.uk>
Subject: Re: Problem with CME UF5 MIDI keyboard master
	volume	slider
Date: Mon, 13 Aug 2007 16:38:40 +0100
Message-ID: <1187019520.3219.5.camel@localhost.localdomain>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
	<1186581239.3160.6.camel@localhost.localdomain>
	<1186584284.2915.1204373387@webmail.messagingengine.com>
	<1186590962.3160.10.camel@localhost.localdomain>
	<1186648031.27177.1204511703@webmail.messagingengine.com>
	<1186757723.30437.1204736811@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra05.ch.as12513.net (mra05.ch.as12513.net [82.153.254.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 734C310388F
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Aug 2007 17:39:36 +0200 (CEST)
In-Reply-To: <1186757723.30437.1204736811@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-08-10 at 16:55 +0200, Clemens Ladisch wrote:
> I wrote:
> > Damon Chaplin wrote:
> > > Is it possible to workaround the problem?
> > 
> > Only by changing the driver.  Please wait until tomorrow.
> 
> Well, the driver should now continue after receiving bad data.
> 
> To be able to convert the data sent by the CME UFx to a real master
> volume message, I need to know the data format at a lower level.
> Please change line 58 of sound/usb/usbmidi.c to
> 	#define DUMP_PACKETS
> and recompile the driver, then show the entries that are written to the
> (debug) system log when a master volume message is received.

Here they are. Only one byte changes as the slider moves,from 00 to 7f:

received packet: [ 0f f0 7f 7f 04 01 7f 00 f7 ]
received packet: [ 0f f0 7f 7f 04 01 7f 7f f7 ]
                                        ^^

Damon
