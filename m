From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Quick devfs question.
Date: Wed, 20 Mar 2002 19:51:03 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10203201945210.3161-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


So I just installed devfs, and now seemingly have everything up and
running.  There's just one problem that I'm encountering.

I'm using that trick of setting my rear channel duplicating my front
channel with my .asoundrc setup as:

pcm.ch4dup {
	type plug
	slave.pcm surround40
	ttable.0.0 1
	ttable.1.1 1
	ttable.0.2 1
	ttable.1.3 1
}

pcm.dsp0 pcm.ch4dup

Though this still works with alsaplayer (with the -d dsp0 flag), aoss no
longer works.  

Any ideas?

Adam



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
