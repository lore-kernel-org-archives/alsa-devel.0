From: Justin Cormack <justin@street-vision.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: 31 Mar 2003 15:20:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049120453.1373.3.camel@lotte>
References: <Pine.LNX.4.44.0303311307170.1602-100000@pnote.perex-int.cz>
	<XFMail.20030331150304.pochini@shiny.it>
	<20030331144500.GA20506@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tench.street-vision.com ([212.18.235.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA20606
	for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2003 16:21:07 +0200
In-Reply-To: <20030331144500.GA20506@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@pgb.unsw.edu.au>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-03-31 at 15:45, Matt Flax wrote:
> I think this is a great step forward ... it will open the door for 3D 
> array audio applications.
> Typically these applications use 3D speaker arrays which each have 
> individual gains set for each audio 'object'.
> Consequently depending on an audio object's location in 3D space, will 
> depend on the relative speaker gains for that particular audio object.
> 
> Consequently each audio object has its own mixer matrix. There is also a 
> master mixer matrix for calibration - this generally occurs when you 
> have external amplifiers which are different or not calibrated.

You can already do this with the hdsp matrix mixer (in fact I have with
8 speakers). Each channel has a mixer level for each speaker. For hdsp
you get 26 playback channels, ie 26 objects (plus the capture channels
too).

The thread is just about whether to tidy up the way the interface is
exposed.

Justin




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
