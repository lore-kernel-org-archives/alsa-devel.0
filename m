From: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Subject: snd_pcm_commit asserts
Date: Fri, 11 Jun 2004 11:30:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1BYiMf-0006Oc-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hello!

Using alsa 1.0.4 the following problem occurs.

If in between a snd_pcm_mmap_begin and snd_pcm_mmap_commit a xrun occured
I'm not (always) able to do a successful commit.

If in XRUN state the snd_pcm_mmap_commit returns error code -32 (broken
pipe). Getting this I do xrun recovery with bringing alsa into state
PREPARED and repeating the snd_pcm_mmap_commit call. Some times this may
succeed but most of the time it fails again, this time with an assertion:

pcm.c:5945: snd_pcm_mmap_commit: Assertion `offset == *pcm->appl.ptr %
pcm->buffer_size' failed.

Another approach to prevent the first failing commit (the one returning
broken pipe error) is to check immediately before calling snd_pcm_commit
the state and ensure to be either in RUNNING state or in PREPARED state
respectively. So if the XRUN occured after snd_pcm_mmap_begin and before
calling snd_pcm_mmap_commit alsa is in state PREPARED when doing the
commit.  Sometimes this works, sometimes the snd_pcm_mmap_commit call
throws again

pcm.c:5945: snd_pcm_mmap_commit: Assertion `offset == *pcm->appl.ptr %
pcm->buffer_size ' failed.

Nevertheless the data provided to snd_pcm_mmap_commit is always the same
and corresponds to the data obtained by the mmap_begin call.

The problem appears in playback and capture mode.

Viele Gruesse / best regards
	Nicolas Hueppelshaeuser
--
nicolas hueppelshaeuser, emlix gmbh, http://www.emlix.com,

emlix - your embedded linux partner




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
