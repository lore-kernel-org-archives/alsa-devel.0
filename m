From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [RFC] Extra info via the TLV interface
Date: Mon, 04 Sep 2006 13:48:48 +0100
Message-ID: <44FC20B0.4060501@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to now pass extra info regarding the controls via the TLV
interface.
1) Whether the control is Playback, Capture or Both.
2) Whether the control is digital or analog.
3) Some description of the routing of the control. i.e. how it links to
other controls.
4) Both "short" and "long" mixer control names.
5) Control grouping. I.e. to have mixer controls "Front" and "Surround"
next to each other.

I know (1) sort of works just by adding playback or capture to the
control name, but it seems to fail in some ambiguous cases. E.g.
"Capture feedback", "Mic Boost", "HD Source", "HD Channel"

Any comments?

James

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
