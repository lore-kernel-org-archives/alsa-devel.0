From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: newbie problem with control settings
Date: Thu, 24 Mar 2005 11:06:40 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503241100420.10960-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.61.0503230124420.5926@redshift.mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 47B0229E
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 11:06:42 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0503230124420.5926@redshift.mimosa.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

D. Hugh Redelmeier wrote:
> I must say that some of the controls have odd names.  One that really
> surprised me was "IEC958 Copyright" with a choice of mute or not.  (I
> do now have an idea what this is about.)

"IEC958" is S/P-DIF.  This control enables the copyright bit which can
cause receiving devices to disable digital recording.

> Recommendation: I think that there should be support for controls with
> enumerated type values.

The support is there, but these controls are implemented as booleans
in the hardware.

An additional mixer API that can map these controls to more
user-friendly ones is being planned.

> Perhaps also boolean controls that could have a name other than
> "mute".

These controls aren't named "Mute"; this is a gnome-volume-control
bug.


HTH
Clemens



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
