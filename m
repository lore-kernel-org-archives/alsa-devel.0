From: Dave Maley <dmaley@nc.rr.com>
Subject: Re: Re: rmedigicontrol error w/ 2.6.11 based kernels
Date: Sat, 18 Jun 2005 14:52:14 -0400
Message-ID: <1119120734.4795.3.camel@homer>
References: <1118985708.4845.7.camel@homer> <20050617185440.GA3067@tuba>
	 <1119035061.19620.42.camel@kodos.rdu.redhat.com>
	 <20050617212503.GA3272@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3ayDKRwTyJU45xmZCQqk"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ms-smtp-02-eri0.southeast.rr.com (ms-smtp-02-lbl.southeast.rr.com [24.25.9.101])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36275177
	for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2005 20:52:21 +0200 (MEST)
In-Reply-To: <20050617212503.GA3272@tuba>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: postmaster@robertvetter.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-3ayDKRwTyJU45xmZCQqk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > > There was a change in the mixer (enumerates) and I forgot to change
> > > rmedigicontrol, too. But this patch removes 
> > > "snd_ctl_elem_value_get_enumerated()" for the rme32/rme96 cards now.
> > > The patch is only tested with a rme32 card here.
> > 
> > Thanks much for the quick response.  I'll test this patch w/ my digi96/8
> > PST card and let you know how things go.
> 
> Please try this patch instead. The former one is wrong. Sorry.

That did the trick.  rmedigicontrol's working nicely now w/ my 2.6.11
based kernels.  Thanks much!

The attached patch (essentially a 1-liner) is all I ended up needing to
use.  This was patching the sources from alsa-tools-1.0.9 ...

Thanks again!

Cheers,
Dave

--=-3ayDKRwTyJU45xmZCQqk
Content-Disposition: attachment; filename=rme_getinteger.patch
Content-Type: text/x-patch; name=rme_getinteger.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- rmedigicontrol-1.0.9/rmedigicontrol.c.orig	2005-06-18 13:49:16.000000000 -0400
+++ rmedigicontrol-1.0.9/rmedigicontrol.c	2005-06-18 13:51:06.000000000 -0400
@@ -172,10 +172,11 @@
 		r=gtk_radio_button_new_with_label(group,snd_ctl_elem_info_get_item_name(iv->info));
 		group=gtk_radio_button_group(GTK_RADIO_BUTTON(r));
 		gtk_signal_connect(GTK_OBJECT(r),"toggled",GTK_SIGNAL_FUNC(elem_radio_toggled),(gpointer)iv);
-		if(i==snd_ctl_elem_value_get_enumerated(iv->val,0))
+		if(i==snd_ctl_elem_value_get_integer(iv->val,0))
 			active=r;
 		gtk_box_pack_start(GTK_BOX(box),r,TRUE,FALSE,0);
 	}
+
 	if(active)	
 		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(active),TRUE);
 	frame=gtk_frame_new(elem_name);

--=-3ayDKRwTyJU45xmZCQqk--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
