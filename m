From: "Jason Champion" <jchampion@dsci-usa.com>
Subject: [ALSA-lib] Device Enumeration in Human-Readable Form
Date: Thu, 4 May 2006 18:50:11 -0400
Message-ID: <200605042250.k44MoAHV015522@dsci-usa.com>
References: <20060414015001.9C53A888D2@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060414015001.9C53A888D2@sc8-sf-spam1.sourceforge.net>
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

I am currently working on a multiplatform audio project that uses wxWidgets
+ DirectSound on Windows and wxGTK + ALSA on Linux.  I need to be able to
enumerate the soundcards on the system in Human-readable form, like so:

http://www.bloodlessmushroom/enumeration.gif

Is there a standard way to get this enumeration using ALSA?  I haven't been
able to find any good documentation describing how to do so.  Essentially I
am looking for how to do something more or less equivalent to
DirectSoundEnumerate() in order to grab a list of PCM capture and PCM
playback devices.

Thank you,
Jason Champion



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
