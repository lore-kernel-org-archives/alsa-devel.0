From: Stuart Longland <redhatter@gentoo.org>
Subject: ASoC: Hiding unused CODEC mixer widgets in the machine
	driver
Date: Fri, 6 Aug 2010 10:18:45 +1000
Message-ID: <20100806001844.GM15884@atomos.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 64D1624389
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:25:35 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OhAkc-0004rB-6h
	for alsa-devel@alsa-project.org; Fri, 06 Aug 2010 10:25:30 +1000
Received: from [203.94.56.252] (helo=atomos.dmz.longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OhAkZ-0004qA-7W
	for alsa-devel@alsa-project.org; Fri, 06 Aug 2010 10:25:30 +1000
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: tiwai@suse.de, lrg@slimlogic.co.uk, broonie@opensorce.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi all,

Work has continued on the TLV320AIC3204 CODEC driver, and there have
been a number of fixes since the last patch was published.  However,
this CODEC is a rather complicated beast to drive, some may find the
controls a little unweildy, and as such, I was wondering if the machine
driver could be used to abstract this for a given target?

It's no use abstracting this in the CODEC, because some may want to
access the functionality I'm trying to hide.

The CODEC we're using has three line inputs; which may be treated as
either three mono differential inputs, or three stereo single-ended
inputs.  There are also a couple of common-mode sources that may be
connected.  The resistances connecting these is selectable; 10k, 20k or
40k... and as such, it's possible to do some hardware mixing of the
sources inside the CODEC.

At the moment I have each of the inputs to the ADC's PGA ("MICPGA"),
with one control for each possible path... There are two ADCs, so two
PGAs... and the inputs can be connected to either the negative or
positive terminal of the PGA in many cases.  That leads to a large
number of controls (the following is from amixer):

Simple mixer control 'Left MICPGA+ Output Mixer IN1L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA+ Output Mixer IN1R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA+ Output Mixer IN2L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA+ Output Mixer IN3L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'
Simple mixer control 'Left MICPGA- Output Mixer CM1L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA- Output Mixer CM2L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA- Output Mixer IN2R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Left MICPGA- Output Mixer IN3R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'
[...]
Simple mixer control 'Right MICPGA+ Output Mixer IN1R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'
Simple mixer control 'Right MICPGA+ Output Mixer IN2L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Right MICPGA+ Output Mixer IN2R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Right MICPGA+ Output Mixer IN3R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'
Simple mixer control 'Right MICPGA- Output Mixer CM1R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Right MICPGA- Output Mixer CM2R',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: 'not-connected'
Simple mixer control 'Right MICPGA- Output Mixer IN1L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'
Simple mixer control 'Right MICPGA- Output Mixer IN3L',0
  Capabilities: enum
  Items: 'not-connected' '10k' '20k' '40k'
  Item0: '10k'

These controls are useful to a machine driver for implementing controls,
but they're not that friendly to an end user.  I was wondering if it was
possible to hide these controls from the userland, but expose them to
the machine driver to be presented to the user in a more meaningful
manner.  (i.e. we can have just simple mute switches for IN1 and IN3,
labelling them "handset" and "internal mic" in our device).

Or would I be better defining these controls in the machine driver?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
