From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: two soundcards as one, for recording?
Date: Tue, 26 Aug 2003 18:44:22 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.56.0308261810590.257240@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi. I have M-Audio Delta 1010LT and Audiophile 2496 cards, running
2.6.0-test4. I tested the asoundrc magic described in

http://article.gmane.org/gmane.linux.alsa.devel/1946/match=asoundrc+soundcards

but without any success. Got the following error:

arecord: set_params:787: Broken configuration for this PCM: no
configurations available

I can record from both (not at the same time of course) with 'arecord -D
default:0 -c 8 [...]' (for 1010LT) and 'arecord -D default:1 -c 2 [...]'
(for 2496), so the cards and their configuration work ok.

I was hoping to get 10 channel recording done with these two cards. They
sync together through SPDIF, so no drifting should occur. And if possible,
get 12 channels by adding the free SPDIF input as one stereo source to the
combination.

(1010LT has 8 analog inputs, 2496 has two)

The solution would be if arecord worked with JACK, but since I can't
find any information on that, I'll have to live without.


Any ideas?

Tommi Uimonen


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
