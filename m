From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001200]: rmedigicontrol error: Assertion `obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed
Date: Sun, 19 Jun 2005 07:39:24 +0200
Message-ID: <aa62bf4b7d95b43149d7a07dafbb2917@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 271EB19A
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2005 07:39:25 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1200> 
======================================================================
Reported By:                dmaley
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1200
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-17-2005 19:17 CEST
Last Modified:              06-19-2005 07:39 CEST
======================================================================
Summary:                    rmedigicontrol error: Assertion `obj->type ==
SND_CTL_ELEM_TYPE_ENUMERATED' failed
Description: 
I'm running into a problem w/ the latest FC3 kernel (2.6.11-1.27_FC3).  The
problem occurs when I try to run rmedigicontol from alsa-tools.  This was
working just fine w/ the 2.6.9 and 2.6.10 based FC3 kernels, however now
with 2.6.11-1.14_FC3 I'm getting the following error:

[dave@homer tunes]$ rmedigicontrol
rmedigicontrol: control.c:1686: snd_ctl_elem_info_get_items: Assertion
`obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed.
Aborted
[dave@homer tunes]


In looking at the attached strace output it appears that it's unable to
find some needed ioctls:

ioctl(3, USBDEVFS_CONNECTINFO, 0x807daf8) = -1 ENOENT (No such file or
directory)
ioctl(3, USBDEVFS_IOCTL, 0x807dc10)     = -1 ENOENT (No such file or
directory)
write(2, "rmedigicontrol: control.c:1686: "..., 123) = 123
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
tgkill(4714, 4714, SIGABRT)             = 0
--- SIGABRT (Aborted) @ 0 (0) ---
+++ killed by SIGABRT +++


Any thoughts as to what's changed that could be causing this problem?
======================================================================

----------------------------------------------------------------------
 dmaley - 06-18-05 20:55 
----------------------------------------------------------------------
I was sent a patch by Martin Langer which resolved this bug for me.  Below
is the original patch sent to me by Martin, and I've attached the patch I
actually used, which is essentially just a 1-liner.

Thanks Martin!

-----

On Fri, Jun 17, 2005 at 03:04:21PM -0400, Dave Maley wrote:
> On Fri, 2005-06-17 at 20:54 +0200, Martin Langer wrote:
> > On Fri, Jun 17, 2005 at 01:21:48AM -0400, Dave Maley wrote:
> > > Hello.  I've been happily using rmedigicontrol for a while now
(thanks
> > > for the great app) but have run into a problem when running 2.6.11
based
> > > kernels.  My audio workstation runs Fedora Core 3 and w/ the 2.6.9
and
> > > 2.6.10 based kernels rmedigicontrol works great.  However when I run
1
> > > of the 2.6.11 based kernels I get this error:
> > > 
> > > [dave@homer DOWNLOADS]$ rmedigicontrol
> > > rmedigicontrol: control.c:1686: snd_ctl_elem_info_get_items:
Assertion
> > > `obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed.
> > > Aborted
> > 
> > There was a change in the mixer (enumerates) and I forgot to change
> > rmedigicontrol, too. But this patch removes 
> > "snd_ctl_elem_value_get_enumerated()" for the rme32/rme96 cards now.
> > The patch is only tested with a rme32 card here.
> 
> Thanks much for the quick response.  I'll test this patch w/ my
digi96/8
> PST card and let you know how things go.

Please try this patch instead. The former one is wrong. Sorry.

martin

(rmedigicontrol.patch)

Index: rmedigicontrol.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/rmedigicontrol/rmedigicontrol.c,v
retrieving revision 1.3
diff -u -r1.3 rmedigicontrol.c
--- rmedigicontrol.c    29 Nov 2004 15:09:16 -0000      1.3
+++ rmedigicontrol.c    17 Jun 2005 21:11:47 -0000
@@ -100,7 +100,7 @@
        loopback_box=create_loopback_toggle();
        gtk_box_pack_start(GTK_BOX(col1_box),loopback_box,TRUE,FALSE,0);
 
-               clock_box=create_enum_elem_radio("Sample Clock
Source",&clock_iv);
+       clock_box=create_enum_elem_radio("Sample Clock
Source",&clock_iv);
        gtk_box_pack_start(GTK_BOX(col1_box),clock_box,TRUE,FALSE,0);
 
        gtk_box_pack_start(GTK_BOX(main_box),col1_box,TRUE,FALSE,8);
@@ -172,14 +172,15 @@
               
r=gtk_radio_button_new_with_label(group,snd_ctl_elem_info_get_item_name(iv->info));
                group=gtk_radio_button_group(GTK_RADIO_BUTTON(r));
               
gtk_signal_connect(GTK_OBJECT(r),"toggled",GTK_SIGNAL_FUNC(elem_radio_toggled),(gpointer)iv);
-               if(i==snd_ctl_elem_value_get_enumerated(iv->val,0))
+               if(i==snd_ctl_elem_value_get_integer(iv->val,0))
                        active=r;
                gtk_box_pack_start(GTK_BOX(box),r,TRUE,FALSE,0);
        }
-       if(active)      
+       if(active)
               
gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(active),TRUE);
        frame=gtk_frame_new(elem_name);
        gtk_frame_set_shadow_type(GTK_FRAME(frame),GTK_SHADOW_IN);
        gtk_container_add(GTK_CONTAINER(frame),box);
        return frame;
 }
+

----------------------------------------------------------------------
 dmaley - 06-19-05 07:39 
----------------------------------------------------------------------
This bug should be filed against alsa-tools however I can't see how to
change the catagory.  Also I just noticed the policy about providing email
addresses.  Martin Langer <martin-langer@gmx.de> provided me w/ this fix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 19:17 dmaley         New Issue                                    
06-17-05 19:17 dmaley         File Added: rmedigicontrol.bad.trace              
     
06-17-05 19:17 dmaley         File Added: rmedigicontrol.good.trace             
      
06-17-05 19:20 dmaley         Note Added: 0005077                          
06-17-05 19:20 dmaley         Issue Monitored: dmaley                      
06-18-05 20:55 dmaley         Note Added: 0005084                          
06-18-05 20:56 dmaley         File Added: rme_getinteger.patch                  
 
06-19-05 07:39 dmaley         Note Added: 0005085                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
