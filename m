From: fmoraes@nc.rr.com
Subject: Quake 3 demo
Date: Mon, 26 Jul 2004 19:44:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <13c0efcd8.fcd813c0e@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-language: en
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anyone tried to investigate why the Quake 3 demo doesn't work with ALSA?

I've tried running it directly, but it fails with :

------- sound initialization -------
/dev/dsp: Broken pipe
Could not toggle.

Then, when running with aoss I get this:

trFMV::play(), playing idlogo.RoQ
q3demo.x86: pcm.c:5957: snd_pcm_mmap_commit: Assertion `frames <= snd_pcm_mmap_avail(pcm)' failed.
Received signal 6, exiting...

Any ideas?

Francisco



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
