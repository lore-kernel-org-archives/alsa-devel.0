From: Giuliano Pochini <pochini@shiny.it>
Subject: .hw_free() while audio is running ??
Date: Sun, 8 Aug 2004 17:29:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040808172946.43212219.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



It happened that the hw_free() callback was called for a running substream.
System freezed. I had a look to the other drivers and none of them seems to
take into account this possibility and my driver also doesn't support it. If
it's my fault, please ignore the following.

Some details:

The call sequence in the logs is:

pcm_trigger (start)	- of two synced ss's
pcm_hw_free (playback ss)
Crash, nothing more in the logs :(

trigger(stop) wasn't called before hw_free.

I was attempting to write a program that plays and records at the same time
with synced substreams and that program is an awful pile of bugs :)

Alsa-lib 1.0.4
Alsa-driver 1.0.6rc1
Linux 2.6.7
Gcc 3.4.1 (ppc 7455)


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
