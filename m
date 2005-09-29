From: foo bar <foobum@gmail.com>
Subject: (nforce4|CK804|ALC850) digital output problem
Date: Fri, 30 Sep 2005 00:21:52 +0100
Message-ID: <b65bc0e50509291621h1f40c8c7j5ae1b0cc01cf4230@mail.gmail.com>
Reply-To: foo bar <foobum@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi all,

The digital output of my nforce4/ck804/alc850/'whatever it's called'
(intel8x0 driver) is almost working correctly. The problem is that to
hear anything I have to flip the 'IEC958 Playback Switch" mixer
control to off *after* starting playback. Starting playback has the
effect of flipping the switch to on and therefore I have to flip the
control to off after the beginning of each new playback, which gets
quite tedious :).

I've tried alsa-driver/lib versions from 1.0.6 (since I saw somewhere
that it worked back then - didn't for me) up to 1.0.10rc1 and all
exhibit the same behaviour. Why would starting playback affect a mixer
control? Where should I start looking for the relevant code? Is there
an easy workaround?

Thanks,

foobum


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
