From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: intel8x0 still fails to resume in rc2. -- please solve this before the final release!
Date: Sat, 6 Dec 2003 12:36:03 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031206203603.48879.qmail@web21003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Hi.

I am sorry to report that the problem, which disappeared with pre1 and re-appeared in pre2, is
still there in rc2 (so that's not the nug resolved, I assume).

As before, adding a hard-coded wait in the resume phase, before resuming the ac97's, solves the
problem.  Without this, many registers don't get written correctly.

Here is what happens without the waiting:

Dec  6 15:31:38 pisica kernel: PEZZ: codec 0: resuming
Dec  6 15:31:38 pisica kernel: PEZZ: bad register  2: wrote 1616 got 8000
Dec  6 15:31:38 pisica kernel: PEZZ: bad register  6: wrote 801f got 8000
Dec  6 15:31:38 pisica kernel: PEZZ: bad register  a: wrote 801e got 0000
Dec  6 15:31:38 pisica kernel: PEZZ: bad register  c: wrote 801f got 8008
Dec  6 15:31:38 pisica kernel: PEZZ: bad register  e: wrote 001f got 8008
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 10: wrote 9f1f got 8808
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 12: wrote 0505 got 8808
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 14: wrote 9f1f got 8808
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 16: wrote 9f1f got 8808
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 18: wrote 0000 got 8808
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 1c: wrote 0f0f got 8000
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 1e: wrote 800f got 8000
Dec  6 15:31:38 pisica kernel: PEZZ: codec 1: resuming
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 1c: wrote 8a06 got 0000
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 3e: wrote f200 got ff00
Dec  6 15:31:38 pisica kernel: PEZZ: bad register 40: wrote 2ee0 got bb80
Dec  6 15:31:38 pisica kernel: PEZZ: codec 2: not resuming


If I add some waiting time (HZ/4 suffices, I didn't test for less) I get rather:

Dec  6 15:33:21 pisica kernel: PEZZ: codec 0: resuming
Dec  6 15:33:21 pisica kernel: PEZZ: bad register 2a: wrote 0009 got 0209
Dec  6 15:33:21 pisica kernel: PEZZ: codec 1: resuming
Dec  6 15:33:21 pisica kernel: PEZZ: bad register 1c: wrote 8a06 got 0000
Dec  6 15:33:21 pisica kernel: PEZZ: bad register 3e: wrote f200 got ff00
Dec  6 15:33:21 pisica kernel: PEZZ: bad register 40: wrote 2ee0 got bb80
Dec  6 15:33:21 pisica kernel: PEZZ: codec 2: not resuming

And everything's fine.

Itay

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
