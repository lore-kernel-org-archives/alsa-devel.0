From: Giuliano Pochini <pochini@shiny.it>
Subject: C++ driver ?
Date: 01 Mar 2003 14:31:44 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046529108.13656.23.camel@Jay>
References: <s5hof50zmhx.wl@alsa2.suse.de>
	<Pine.HPX.4.33n.0302281144030.5750-100000@studcom.urz.uni-halle.de>
	<s5hof4wihea.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof4wihea.wl@alsa2.suse.de>
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

Is there any chance to write a driver in C++ ?  I'll get an Echoaudio
card soon, so I started to study the "Writing an ALSA driver" tutorial
by T.Iwai and the C++ sources of the generic driver by Echoaudio. That
drivers do not use exceptions (VVindos don't like it), but things as
simple as a "new" do not work in kernel context. Did someone write a C++
support library or I have to convert everything to C ? Suggestions are
welcome...


Bye.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
