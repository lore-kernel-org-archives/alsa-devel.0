From: David Lloyd <dmlloyd@tds.net>
Subject: ALSA and Video4Linux
Date: Tue, 20 Jan 2004 13:58:01 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401201345520.5617@tomservo.workpc.tds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Just for fun, I was looking at adding ALSA sound to a video4linux video 
capture card driver.  I was wondering, does it make more sense to have the 
ALSA portion reside in a separate driver, or integrated with the v4l 
driver for the card?

All the docs I've read about writing an ALSA driver indicate that the
kernel APIs really lend themselves to be standalone drivers.  But this
would cause a lot of duplicate code at least, and resource contention at
worst, since a lot of times it seems the audio hardware is integrated 
right with the video capture device or chip.

On the other hand, integrating ALSA into a v4l device seems very 
complicated (just because v4l device drivers seem complicated to me).

I do know that at least one v4l driver has OSS support in it... I don't
know whether that has any bearing on the principle of integrating sound
and video into a single driver, and I do not know if ALSA has ever been
integrated with a v4l driver in the past.

Thanks for your input.

- D


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
