From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usx2y dependencies
Date: Mon, 2 Feb 2004 22:08:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202210853.GA622@tuba.home>
References: <20040124002328.GA1946@tuba.home> <s5hy8rvui3n.wl@alsa2.suse.de> <20040126230743.GA681@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040126230743.GA681@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, annabellesgarden@yahoo.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2004 at 12:07:43AM +0100, Martin Langer wrote:
> On Mon, Jan 26, 2004 at 11:20:12AM +0100, Takashi Iwai wrote:
> > At Sat, 24 Jan 2004 01:23:28 +0100,
> > Martin Langer wrote:
> > > 
> > > usx2y build by "./configure --with-cards=usb-usx2y" has a dependency problem:
> > > 
> > 
> > try the attached patch.
> > 
> 
> It's perfect :) Please commit it.
> 

I have an improvement. Because I haven't checked MIDI dependencies before :-(
But this patch enables the MIDI stuff now.

martin


Index: alsa-driver/acore/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/seq/Makefile,v
retrieving revision 1.14
diff -u -r1.14 Makefile
--- alsa-driver/acore/seq/Makefile	11 Nov 2003 13:12:16 -0000	1.14
+++ alsa-driver/acore/seq/Makefile	2 Feb 2004 20:58:00 -0000
@@ -12,6 +12,7 @@
 obj-$(CONFIG_SND_AU8810) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_AU8820) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_AU8830) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_USB_USX2Y) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 
 export-objs  := seq_device.o seq.o seq_instr.o seq_midi_emul.o \
 		seq_midi_event.o seq_virmidi.o


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
