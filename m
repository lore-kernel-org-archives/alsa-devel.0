From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: au8820 Joystick MIDI port
Date: Mon, 8 May 2006 09:34:28 +0100
Message-ID: <200605080934.28107.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For those who are interested:
> Are your able to test whether 15-pin connector is accessed by
> VORTEX_LEGACY_PORT and 26-pin connector is accessed by VORTEX_HW_AUREAL ?

I have made up a joystick port MIDI OUT lead for testing.  MIDI sent to the 
au8820 port shown in aplaymidi -l goes to both the wavetable card and the 
joystick midi at the same time; the DB50XG is then generating sound at the 
same time as an external keyboard/synth connected from the joystick 
connector.  So it would seem the card has a single port feeding both.

Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
