From: Torsten Mohr <tmohr@s.netic.de>
Subject: ALSA Howto capture code
Date: Sat, 24 Jan 2004 16:59:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401241659.46913.tmohr@s.netic.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi everybody,

i compiled the example code to capture data in
"A Tutorial on Using the ALSA Audio API".

It works fine as it is.

I then put everything except "readi()" into an
init() function and just "readi()" into a capture()
function.

When i now call init() once and capture() several
times, everything is ok.

But whenever there's a delay between the calls to
capture, it dies with "Speicherzugriffsfehler",
i think that translates to "Memory access error".

I don't know why it is like this, but i hate it.

How can i change it to work?

I think i need to add calls to snd_pcm_pause()?


Thanks for any hints,
Torsten.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
