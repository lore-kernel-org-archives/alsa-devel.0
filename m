From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: GR-55 Driver
Date: Thu, 12 May 2011 11:20:48 -0700
Message-ID: <1305224448.5083.37.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 38564243FF
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 20:20:50 +0200 (CEST)
Received: by pvf33 with SMTP id 33so953671pvf.38
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 11:20:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I need a Driver for the Roland GR-55 Guitar Synthesizer, not sure how to
get started, so I thought this would be a good place to ask.

The GR-55 has MIDI and AUDIO

KSNAME_Wo11="WaveOut1-1"
WDM.Wo11.szPname="OUT (GR-55)"

KSNAME_Wi11="WaveIn1-1"
WDM.Wi11.szPname="IN (GR-55)"

KSNAME_Md11="Midi1-1"
WDM.Md11.szPname="GR-55"

My thinking is that there may be a driver that is similar, or someone
could already be working on a driver, if so, I would like to find out if
I could work on that project or if I could start a new project here. 

I did contact Roland about getting help in the way of Documentation; but
was told not to count on it since most of this documentation is
proprietary; so I might end up having to snoop the information to
reverse engineer it.

I have been a programmer for over 30 years, and have written Unix
drivers and interfaces back in the 80's; things have changed since then
and Linux is Unix like, but ALSA seems a lot easier than what we did
back in those days. I can get up to speed with just a point in the right
direction. Things like do I do this as a driver or a module? Are just a
few questions that I need answers to, just to get started.

Can you recommend a driver that is close enough to use as a template to
start a new driver from?

Thanks.

Jeff Flesher
