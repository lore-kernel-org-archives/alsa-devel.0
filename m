From: Paul Davis <pbd@op.net>
Subject: JACK Audio Connection Kit 0.34.0 released
Date: Tue, 28 May 2002 00:14:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205280414.g4S4ETq10328@op.net>
Reply-To: linux-audio-dev@music.columbia.edu
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA03214
	for <alsa-devel@alsa-project.org>; Tue, 28 May 2002 06:11:26 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-announce@music.columbia.edu
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


                   Jack Audio Connection Kit 0.34.0 Released
                                       
   The Jack team is pleased to announce the release of version 0.34.0 of
   the Jack low-latency audio server. Jack allows applications to share
   data and audio devices in synchronous operation, and has already seen
   many months of hard testing and refinement. The API has essentially
   stabilized for the foreseeable future, although backwards
   compatibility is not guaranteed. More information on Jack is available
   at the group's web site, [1]http://jackit.sourceforge.net/.
   
   Source and binary packages for Jack 0.34.0 are available [2]here.
   
Features and Enhancements

     * Simple, powerful architecture allows audio applications to share
       data
     * Growing number of [3]jackified applications
     * Modular driver system can accept many kinds of audio drivers
     * Dithered noise shaping in the alsa driver (optional)
     * Support for real-time operation using either root privileges or
       POSIX 1.e capabilities
     * Hardware monitoring support for ice1712 and hammerfall sound cards
       
   Work is ongoing to improve transport control and total latency
   calculations.
   
   Developers and users interested in Jack should sign up to
   [4]jackit-devel, our mailing list.
   
Contributors

     * Paul Davis -- principal author
     * Kai Vehmanen -- design, debugging, general code-fu
     * Steve Harris -- dsp mastery
     * Andy Wingo -- autotools work, code fixes, web site
     * Andy Lo A Foe -- debugging
     * Taybin Rutkin -- doc work, code fixes
     * Fernando Pablo Lopez-Lezcano -- capabilities support, rpm work
     * Christian Schaller -- rpm work
     * Anthony van Groningen -- ice1712 support
     * Jörn Nettingsmeier -- jack system diagram
     * Matt Kraai -- fix typos
     * Stefan Kost -- solaris driver
     * Stefan Schwandter -- debian packages

References

   1. http://jackit.sourceforge.net/
   2. http://jackit.sourceforge.net/releases/current/
   3. http://jackit.sourceforge.net/apps/
   4. http://jackit.sourceforge.net/lists/

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
