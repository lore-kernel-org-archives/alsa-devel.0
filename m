From: alsa-devel@robdye.net
Subject: Re: HDSP 9652: Input channel corruption
Date: Wed, 15 Oct 2003 15:01:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066255261.3f8dc39da8799@scorpio.lunarpages.com>
References: <20031009111238.B5188@nautronix.com.au>  <1065672448.3693.12.camel@Wizard.knechthome.com>  <20031010165526.A10106@nautronix.com.au> <1065814483.2164.23.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1065814483.2164.23.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


It sounds to me that the problem Nick Arnold is describing is that in
single-speed (48kS/s) mode, channels 0, 8, and 16 have a 1-sample delay
with respect to all the other channels (using 0-based indexing for
channel numbers here).  This is irrelevant when recording uncorrelated
signals, and subtle when dealing with time-coherent signals
(single-point stereo or Ambisonic for example).  When splitting one
signal across two channels, it is deadly.

The easiest way to check this is to digitally generate a high frequency
sine wave (say 10kHz), and patch it (digitially) to channels 0 and 1 or
8 and 9 (or just go ahead and send it to all the channels).  Make sure
that there are no mismatched delays in whatever tool(s) you use to make
the patches.  Record this signal -- even a few milliseconds is enough.

Then look at it in a waveform editor and zoom way in so you can see the
individual samples.  Check the temporal alignment between track 1 and
track 2 (using 1-based indexing here).  Better yet, subtract the two
tracks.  If all is well the result will be zero; if they are misaligned,
you'll get another 10k sine wave with lower amplitude.

I don't have digital generator in the same setup as my HDSP (independent
of the HDSP that is).  So, I can't do this test without a lot of moving
around.  I am interested in seeing this (possible) problem taken care of.

--Rob



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
