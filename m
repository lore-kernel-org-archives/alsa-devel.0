From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Tue, 24 Feb 2004 18:58:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402241856320.5168-100000@studcom.urz.uni-halle.de>
References: <200402241751.RAA03643@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200402241751.RAA03643@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Will <walsac2@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Will wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
> >>  I'm getting empty MIDI files containing only the MIDI header.
> >
> >Are you using the latest CVS version of ALSA?
> >Some of the bugfixes I sent yesterday are needed by arecordmidi.
>
> No, but I applied your patches to alsa-lib-1.0.3rc1 and Linux 2.6.3 in
> include/sound/asequencer, sound/* etc.  Is that enough to get a
> working ALSA sequencer?

If you recompiled both alsa-driver and alsa-lib packages, yes.

Perhaps I should test more; the latest tests were made only against
data recorded through the snd-seq-dummy client (this is where the
unpatched sequencer would fail).

If you get correct output when you run "amidi -p virtual -d" and
aconnect your keyboard to that port, then it may be a bug in
arecordmidi.  I'll test when I'm at home.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
