From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: A few ideas about environmental audio...
Date: Wed, 17 Mar 2004 10:58:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079535532.1993.28.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>, Openvortex <openvortex-dev@nongnu.org>
List-Id: alsa-devel@alsa-project.org

Hi,

So far i'm following this list, there are some people interested in
environmental audio, and advanced effect processing support. Regarding
this i would like to share some thoughts about and hopefully collect
some critics and comments.

How i visualize environmental audio for the common user:

  Context: The user has a Soundboard with several audio outputs (most of
them do). He/She may connect just a headphone or 2 speakers or a 5.1
setup, 7.1, or whatever the card supports.

  Problem: It's up to the application to support either 5.1, headphones
or whatever. You may end up not hearing some channels (your soundcard
has 6 outputs, but you just have headphones, or you have 6 speakers and
your are hearing a stereo stream on just 2 speakers). There is a lot of
duplicated code in different applications, and there is no standard
about how this down or up mix should be done. It may be impossible to
exploit any advanced hardware feature (see Advantage).
  Idea: Support any audio channel arrangement, and mix it in hardware or
software (plugins, dmix ?) to the actual number of speaker/headphones
channels. Define a standard how channel formatting should be
converted/mixed, etc.
  Requirements: The user has to tell ALSA what kind of
speakers/headphones is she/he using (not a big deal).
  Advantage: We could support 7.1 or 5.1 environmental audio on
headphones, by using hardware HRTF filters to put each stream at the
desired spatial position. On some soundcards this is trivial (just a
matter of routing).
  Caveats: It involves work obviously. I'm willing to volunteer on this.

Any comments are gladly welcome.

Best Regards

Manuel







-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
