From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Most simple use of sequencer in alsa
Date: Thu, 14 Feb 2002 07:39:28 +0100 (MET)
Message-ID: <XFMail.020214073928.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h3d0hxy8h.wl@alsa1.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yesterday I was trying to use the sequencer to send a NOTEON EVENT to my
wavetable device. I did

*open the sequencer
*allocated a port_info structure
*filled in port and client to port_info
*attached info to sequencer
*allocated event
*freed event
* freed port structure

I was not able to get further as My program now caused a segfault which i was
not able to solve.

Can anyone email me a simple program to put a NOTEON event to any client/port
of the sequencer. I do not understand pmidi because it is too complex for me to
understand. I'd wish to get/receive/see a simple program with approx 30 lines

Can anybody help me ?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
