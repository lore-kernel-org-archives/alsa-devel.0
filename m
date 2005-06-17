From: Martin Langer <martin-langer@gmx.de>
Subject: Re: rmedigicontrol error w/ 2.6.11 based kernels
Date: Fri, 17 Jun 2005 20:54:40 +0200
Message-ID: <20050617185440.GA3067@tuba>
References: <1118985708.4845.7.camel@homer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 77701138
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 20:53:09 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1118985708.4845.7.camel@homer>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Maley <dmaley@nc.rr.com>
Cc: postmaster@robertvetter.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2005 at 01:21:48AM -0400, Dave Maley wrote:
> Hello.  I've been happily using rmedigicontrol for a while now (thanks
> for the great app) but have run into a problem when running 2.6.11 based
> kernels.  My audio workstation runs Fedora Core 3 and w/ the 2.6.9 and
> 2.6.10 based kernels rmedigicontrol works great.  However when I run 1
> of the 2.6.11 based kernels I get this error:
> 
> [dave@homer DOWNLOADS]$ rmedigicontrol
> rmedigicontrol: control.c:1686: snd_ctl_elem_info_get_items: Assertion
> `obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed.
> Aborted

There was a change in the mixer (enumerates) and I forgot to change
rmedigicontrol, too. But this patch removes 
"snd_ctl_elem_value_get_enumerated()" for the rme32/rme96 cards now.
The patch is only tested with a rme32 card here.

Signed-off-by: Martin Langer <martin-langer@gmx.de>


martin

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rmedigicontrol.patch"

Index: rmedigicontrol.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/rmedigicontrol/rmedigicontrol.c,v
retrieving revision 1.3
diff -u -r1.3 rmedigicontrol.c
--- rmedigicontrol.c	29 Nov 2004 15:09:16 -0000	1.3
+++ rmedigicontrol.c	17 Jun 2005 18:33:34 -0000
@@ -100,7 +100,7 @@
 	loopback_box=create_loopback_toggle();
 	gtk_box_pack_start(GTK_BOX(col1_box),loopback_box,TRUE,FALSE,0);
 
-       	clock_box=create_enum_elem_radio("Sample Clock Source",&clock_iv);
+	clock_box=create_enum_elem_radio("Sample Clock Source",&clock_iv);
 	gtk_box_pack_start(GTK_BOX(col1_box),clock_box,TRUE,FALSE,0);
 
 	gtk_box_pack_start(GTK_BOX(main_box),col1_box,TRUE,FALSE,8);
@@ -172,8 +172,6 @@
 		r=gtk_radio_button_new_with_label(group,snd_ctl_elem_info_get_item_name(iv->info));
 		group=gtk_radio_button_group(GTK_RADIO_BUTTON(r));
 		gtk_signal_connect(GTK_OBJECT(r),"toggled",GTK_SIGNAL_FUNC(elem_radio_toggled),(gpointer)iv);
-		if(i==snd_ctl_elem_value_get_enumerated(iv->val,0))
-			active=r;
 		gtk_box_pack_start(GTK_BOX(box),r,TRUE,FALSE,0);
 	}
 	if(active)	

--OXfL5xGRrasGEqWY--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
