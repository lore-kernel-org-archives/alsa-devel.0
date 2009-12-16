From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: CELF Project Proposal - ALSA scenario/use case support
Date: Wed, 16 Dec 2009 17:26:53 +0000
Message-ID: <1260984413.3525.351.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
Sender: linux-embedded-owner@vger.kernel.org
To: CE Linux Developers List <celinux-dev@tree.celinuxforum.org>, linux-embedded <linux-embedded@vger.kernel.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Summary: Complete ALSA hardware scenario/use case support in alsa-lib
and salsa-lib

Proposer: Liam Girdwood

Description:
Modern mobile devices are increasingly required to provide a rich set of
audio functionality required by today's applications. ALSA currently
lacks a portable and high level API to configure audio hardware function
and signal routing.

e.g. there is no portable method atm to configure the audio hardware to
make a "handset gsm phone call" or "handset voip phone call", etc.

This purpose of this project would be to complete the ALSA scenario
manager API and get it accepted upstream in alsa-lib and salsa-lib. The
code is nearly ready for upstream, with some work required on it's file
format as the main piece of outstanding work.

More Info:
** http://www.slimlogic.co.uk/?p=40

API header:
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/ascenario.h;h=b1395515b035629d09cd9b3d3a224743053aa159;hb=ascenario

Development branch now hosted as alsa-lib branch here :-
** http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ascenario


Scope: This project will probably take between 2 - 4 weeks.

Thanks

Liam
