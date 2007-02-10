From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: us428control 0.4.5 [RFC]
Date: Sat, 10 Feb 2007 01:29:38 +0000
Message-ID: <45CD2002.7070802@rncbc.org>
References: <20070205065636.GA1652@elte.hu>
	<200702051525.49465.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200702051525.49465.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Karsten et al.,

After a very long period I've finally got the time and initiative to get
back on continuing us428control implementation details, specially
regarding my US-224 usability as a dedicated DAW control surface.

Almost 3 years ago I had the MMC implementation started but left it in
the bare basic status, that was about the transport and shuttle controls.

Now I wish to have a chance and push it a little bit further and
complete some other things in the process.

Specifically, I'm proposing about the following:

a) SELECT, REC, MUTE and SOLO switching.
b) NULL fader switching.
c) MMC Masked-Write command mapping to REC, MUTE and SOLO[*]

I have already a) and b) working partially, at least for the lightnings
(LEDs) as you can check from [1], with version bumped to
0.4.5; c) will follow promptly on those next days.

I would like your early but valuable comments, whether this effort makes
any sense, specially in regard to the US-428.

[*] I have some fundamental doubts if there's an MMC command information
field for track SOLOing. AFAIK theres only those for track REC and MUTE
status, dunno how can I do the SOLO signaling :( Ah, any hint would be
highly appreciated, specially from someone who has access to the
official MIDI specification, the one regarding MMC Recommended Practices
RP-013 in particular ;)

[1] http://www.rncbc.org/usx2y/us428control-0.4.5-1.tar.gz

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
