From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: Terratec EWX24/96 AC3 passthru wierdness
Date: Mon, 24 Feb 2003 14:57:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302241444470.3322-100000@gullvinge.ii.uib.no>
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

The sound stutters like crazy (but not xrun messages) when doing ac3 
passthru over the spdif, if I decode the ac3 stream to 6 channels and use 
envy24control to mix those to the spdif out there is no stutter (but also 
no proper surround sound). Am I doing something wrong?

relevant part of ~/.asoundrc looks like this:

pcm.ice1712 {
        type hw
        card 1
        device 0
}

pcm.ice1712_spdif {
        type plug
        ttable.0.8 1
        ttable.1.9 1
        slave.pcm ice1712
}

Tested with ac3dec and xine (alsa-* 0.9.0rc7)

-- 
Ronny V. Vindenes <sublett@dc-s.com>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
