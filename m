From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [2.6.32.y] Re: [regression] no sound from Fujitsu Pi laptop unless
 headphones plugged in
Date: Sun, 25 Nov 2012 01:31:36 -0800
Message-ID: <20121125093136.GA21119@elie.Belkin>
References: <1286612714.8879.5.camel@pink>
 <20120101091142.GA4927@elie.hsd1.il.comcast.net>
 <20120101091324.GB4927@elie.hsd1.il.comcast.net>
 <20120216005618.GA29853@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120216005618.GA29853@burratino>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jose Manuel Castroagudin <j@chav.es>, Rafael Varela Pet <rpet@mundo-r.com>
List-Id: alsa-devel@alsa-project.org

Hi Willy,

Please consider

  cfc9b06f0bef ALSA: hda - Add a pin-fix for FSC Amilo Pi1505

for application to the 2.6.32.y tree.  Without this patch, the Amilo
Pi 1505's internal speaker is silent unless a jack is plugged into its
headphone jack.

Jose Manuel Castroagudin noticed[1] that 2.6.30 is not affected, so
this seems to be a regression.

The patch was applied upstream during the 2.6.33 merge window, where
it worked.  That said, I didn't manage to track down anyone with a
Pi1505 to test it against 2.6.32, so thoughts from alsa folks on
whether this is appropriate for 2.6.32.y would be useful.

Hope that helps,
Jonathan

[1] http://bugs.debian.org/599582 has many more details.
