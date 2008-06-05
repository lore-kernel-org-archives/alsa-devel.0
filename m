From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI message handling
Date: Thu, 05 Jun 2008 13:25:26 +0200
Message-ID: <4847CD26.4030705@ladisch.de>
References: <1212522887.17865.14.camel@un1001x>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 94B4B245EA
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 13:25:53 +0200 (CEST)
In-Reply-To: <1212522887.17865.14.camel@un1001x>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-15?Q?Thorsten_Edelh=E4u=DFer?= <toersi@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thorsten Edelh=E4u=DFer wrote:
> I'm writing a driver for the MARIAN MARC 8 Midi soundcard. Today I
> tested some MIDI functionality and get some errors from hydrogen
> ("unhandled midi message type"). I did some research and got to the
> point, that the MIDI alive message (0xfe) should not arrive at the
> application.

The Active Sensing message is a valid MIDI message.  This seems to be a
bug in hydrogen.

> So my question is: Do I have to process the midi messages by myself
> before I give it to the alsa "snd_rawmidi_receive" function?
> Or is there already some code, which will do it?

The ALSA framework handles this automatically; your driver is not
required to interpret the MIDI data stream.


Regards,
Clemens
