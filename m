From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
Subject: dynamic linking
Date: Tue, 23 Apr 2002 19:58:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001501c1eaf8$d359ef00$0400a8c0@martijn>
Reply-To: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA19031
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2002 19:58:44 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

I'm working on a library for accessing MIDI hardware, which uses plugins
to communicate with the hardware. Now I'm not sure how to compile
these shared libraries. Should I use -Bsymbolic? This makes the linker
give a warning when the library is not linked against all the shared
libraries
it needs itself. Still, I don't seem to be able to use the ALSA library (for
rawmidi) when the plugin is not loaded with RTLD_GLOBAL. This may
not be a problem, but I'd like to understand why RTLD_LOCAL won't
work?

Any help would be appreciated.

--martijn




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
