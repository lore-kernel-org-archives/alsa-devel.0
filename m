From: Roland Stigge <stigge@antcom.de>
Subject: Re: Re: Bug#245668: kernel-source-2.6.5:
	intel8x0:	IEC958 output not working anymore
Date: Fri, 03 Sep 2004 18:39:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094229580.4140.7.camel__42316.089946735$1094231457$gmane$org@atari.stigge.org>
References: <Pine.HPX.4.33n.0409031438540.16124-100000@studcom.urz.uni-halle.de>
	 <1094220009.4139.3.camel@atari.stigge.org>  <s5hzn47whwn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from stigge.org (pD9E7EEC6.dip.t-dialin.net [217.231.238.198])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0A51A2CD
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 18:39:42 +0200 (MEST)
In-Reply-To: <s5hzn47whwn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, maks attems <debian@sternwelten.at>, 245668@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 16:23, Takashi Iwai wrote:
> > > Does "aplay something.wav" work?
> > > Does "aplay -D spdif something.wav" work?
> > > If not, what happens?
> > 
> > $ aplay pub/mi1.wav
> > Playing WAVE 'pub/mi1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > Mono
> > $ aplay -D spdif pub/mi1.wav
> > Playing WAVE 'pub/mi1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > Mono
> > aplay: set_params:837: Channels count non available
> 
> use -D plug:spdif

It's nearly like the very first version. Digital output is like muted.
When I played around I noticed that gnome-alsamixer segfaults when I
_uncheck_ "IEC958" during the playback:

Thread 1 (Thread 1088226208 (LWP 4234)):
#0  0x408ebf1f in snd_mixer_elem_get_type () from
/usr/lib/libasound.so.2
#1  0x08050175 in gam_toggle_set_state ()
#2  0x0804ff50 in gam_toggle_get_type ()
#3  0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#4  0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#5  0x40811c25 in g_signal_emit_by_name () from
/usr/lib/libgobject-2.0.so.0
#6  0x40810be7 in g_signal_emit_valist () from
/usr/lib/libgobject-2.0.so.0
#7  0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#8  0x404b3665 in gtk_toggle_button_toggled ()
   from /usr/lib/libgtk-x11-2.0.so.0
#9  0x404b3a12 in gtk_toggle_button_get_inconsistent ()
   from /usr/lib/libgtk-x11-2.0.so.0
#10 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#11 0x407fdfb7 in g_cclosure_new_swap () from
/usr/lib/libgobject-2.0.so.0
#12 0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#13 0x4081144e in g_signal_emit_by_name () from
/usr/lib/libgobject-2.0.so.0
#14 0x40810be7 in g_signal_emit_valist () from
/usr/lib/libgobject-2.0.so.0
#15 0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#16 0x4034e215 in gtk_button_clicked () from
/usr/lib/libgtk-x11-2.0.so.0
#17 0x404b350e in gtk_toggle_button_set_active ()
   from /usr/lib/libgtk-x11-2.0.so.0
#18 0x0804ff50 in gam_toggle_get_type ()
#19 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#20 0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#21 0x40811c25 in g_signal_emit_by_name () from
/usr/lib/libgobject-2.0.so.0
#22 0x40810be7 in g_signal_emit_valist () from
/usr/lib/libgobject-2.0.so.0
#23 0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#24 0x404b3665 in gtk_toggle_button_toggled ()
   from /usr/lib/libgtk-x11-2.0.so.0
#25 0x404b3a12 in gtk_toggle_button_get_inconsistent ()
   from /usr/lib/libgtk-x11-2.0.so.0
#26 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0

[...]

   from /usr/lib/libgtk-x11-2.0.so.0
#14698 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#14699 0x407fdfb7 in g_cclosure_new_swap () from /usr/lib/libgobject-2.0.so.0
#14700 0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
---Type <return> to continue, or q <return> to quit---
#14701 0x4081144e in g_signal_emit_by_name () from /usr/lib/libgobject-2.0.so.0
#14702 0x40810be7 in g_signal_emit_valist () from /usr/lib/libgobject-2.0.so.0
#14703 0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#14704 0x4034e215 in gtk_button_clicked () from /usr/lib/libgtk-x11-2.0.so.0
#14705 0x404b350e in gtk_toggle_button_set_active ()
   from /usr/lib/libgtk-x11-2.0.so.0
#14706 0x0804ff50 in gam_toggle_get_type ()
#14707 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#14708 0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#14709 0x40811c25 in g_signal_emit_by_name () from /usr/lib/libgobject-2.0.so.0
#14710 0x40810be7 in g_signal_emit_valist () from /usr/lib/libgobject-2.0.so.0
#14711 0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#14712 0x404b3665 in gtk_toggle_button_toggled ()
   from /usr/lib/libgtk-x11-2.0.so.0
#14713 0x404b3a12 in gtk_toggle_button_get_inconsistent ()
   from /usr/lib/libgtk-x11-2.0.so.0
#14714 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0
#14715 0x407fdfb7 in g_cclosure_new_swap () from /usr/lib/libgobject-2.0.so.0
#14716 0x407fdc20 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#14717 0x4081144e in g_signal_emit_by_name () from /usr/lib/libgobject-2.0.so.0
#14718 0x40810be7 in g_signal_emit_valist () from /usr/lib/libgobject-2.0.so.0
---Type <return> to continue, or q <return> to quit---
#14719 0x40810ee4 in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#14720 0x4034e215 in gtk_button_clicked () from /usr/lib/libgtk-x11-2.0.so.0
#14721 0x404b350e in gtk_toggle_button_set_active ()
   from /usr/lib/libgtk-x11-2.0.so.0
#14722 0x0804ff50 in gam_toggle_get_type ()
#14723 0x40812121 in g_cclosure_marshal_VOID__VOID ()
   from /usr/lib/libgobject-2.0.so.0

Stack overflow?

This doesn't occur without the "-D [...]" option.

bye,
  Roland




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
