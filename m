From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Subject: newbie problem with control settings
Date: Wed, 23 Mar 2005 02:04:56 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0503230124420.5926@redshift.mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gw-d.mimosa.com (gw-d.mimosa.com [216.126.78.97])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B1DF0289
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 08:04:57 +0100 (MET)
Received: from redshift.mimosa.com (redshift.mimosa.com [192.139.70.107])
	by gw-d.mimosa.com (8.12.8/8.12.8) with ESMTP id j2N74uuS004112
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 02:04:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[I realize that with a bit of knowledge, I wouldn't have had this
problem.  But I think that my experience suggests how to improve
things for other newbies.  By the time I am no longer a newbie, I
will no longer see the things that confuse newbies.]

I updated my system from Fedora Core 1 to Fedora Core 3.  So I
switched from OSS to Alsa.

I had great difficulty getting the sound system to pass line-in
through.  I was trying to use gnome-volume-control to set things up.
Once I understood what was going on, it was easy.

What confused me?  It turns out that my system's sound chip (C-Media
Electronics Inc CM8738 built into my Asus A7V333 motherboard) has a
couple of switches to change the line-in jack into an output.  They are
called "Line-In As Rear" and "Line-In As Bass".  The way to control
them in gnome-volume-control is to select or deselect "mute" for each
of these controls.  I find this not at all obvious.

	Line-In As Bass
	[ ] Mute

	Line-In As Rear
	[ ] Mute

How would I improve it?  I would make the values of these switches be
an enumerated type.  In UI terms: a set of radio buttons.

    Line-in jack is:

    [*] Line-in
    [ ] bass output
    [ ] rear Left and Right output

(Notice that I've replaced two switches with an enumerated type that
has three values.  What happened to the fourth state?  I have no idea
what it would mean, so I didn't provide a choice for it.)

Although I am complaining about gnome-volume-control (not a part of
Alsa), I am guessing that gnome-volume-control is just displaying
names and choices that it is presented by Alsa.

I must say that some of the controls have odd names.  One that really
surprised me was "IEC958 Copyright" with a choice of mute or not.  (I
do now have an idea what this is about.)

Recommendation: I think that there should be support for controls with
enumerated type values.  Perhaps also boolean controls that could have
a name other than "mute".

PS: here are the control names that I extracted from the driver
source.  gnome-volume-control massaged them somewhat.  Some names are
quite obscure.
    Master Playback Volume
    3D Control - Switch
    PCM Playback Volume
    PCM Playback Switch
    PCM Capture Switch
    Synth Playback Volume
    Synth Playback Switch
    Synth Capture Route
    CD Playback Volume
    CD Playback Switch
    CD Capture Route
    Line Playback Volume
    Line Playback Switch
    Line Capture Route
    Mic Playback Volume
    Mic Playback Switch
    Mic Capture Switch
    PC Speaker Playback Volume
    Aux Playback Volume
    Aux Playback Switch
    Aux Capture Switch
    Mic Boost
    Mic Capture Volume
    Four Channel Mode
    Line-In As Rear
    IEC958 Output Switch
    IEC958 In Valid
    IEC958 Copyright
    IEC958 5V
    IEC958 Loop
    IEC958 In Monitor
    IEC958 Playback Default
    IEC958 Playback Con Mask
    IEC958 Playback PCM Stream
    Line-In As Bass
    IEC958 In Select
    IEC958 In Phase Inverse
    Mic As Center/LFE
    Modem


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
