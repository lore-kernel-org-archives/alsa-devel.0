From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Maestro3 hw volume buttons on HP OB6000 (need help from HP)
Date: Fri, 19 Nov 2004 16:19:45 +0200
Message-ID: <20041119141945.GA27175@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261427AbUKSOWX@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I've been trying to get the hardware volume buttons to work on my HP=20
OmniBook 6000 laptop. The audio chip is an ESS Maestro 3 and the specs =
are=20
available. Unfortunately that doesn't seem to be enough to make the=20
buttons work.

There is something messing with hw volume pins since I get a constant=20
flood of events. I can't enable the hw volume interrupt because the sys=
tem=20
will hang under the interrupt load. It does appear that the the buttons=
=20
are actually connected to the right pins since I can see some changes i=
n=20
the data when I press the buttons (observed using another interrupt=20
source).

The laptop requires a HP specific driver even under Windows. Otherwise =
the=20
hw volume buttons don't behave properly (mute and vol up act as mute, v=
ol=20
down does nothing). The standard driver doesn't hang the machine though=
=2E

I'd really appreciate some help from HP.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
