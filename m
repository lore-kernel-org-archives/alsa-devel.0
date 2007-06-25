From: Nathan Allen Stratton <nathan@robotics.net>
Subject: Re: $1000 bounty for getting audio working under linux
 on a Osprey 440
Date: Sun, 24 Jun 2007 21:00:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706242053190.13089@barney.robotics.net>
References: <Pine.LNX.4.58.0706191425360.15975@barney.robotics.net>
	<1182319147.5073.1196082513@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barney.robotics.net (cyber.robotics.net [209.150.98.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EDA91037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 03:00:50 +0200 (CEST)
In-Reply-To: <1182319147.5073.1196082513@webmail.messagingengine.com>
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

On Wed, 20 Jun 2007, Clemens Ladisch wrote:

> Did you try the digital input and the three analog inputs?

Analong inputs are all tied to ground, so no, you don't get anything on
them. I got nothing on digital inputs until I figured out the GPIO by
booting in windows and checking it out with a logic probe.

modprobe bttv card=140 bttv_gpio=1 bttv_verbose=2 bttv_debug=1 gpiomask=0x000303 audioall=0xFFFCFC

The above will let you get audio, but gain is very high by default. The
gain is controlled via the Altera X9221 on address 0x50. I am not sure how
to add support for alsa, but I found old btaudio drivers from viewcast
that are out of date and no longer supported.

ftp://ftp.viewcast.com/pub/OSP-MM/Linux/latest

-Nathan
