From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Query devices in a non-blocking fashion
Date: Sun, 07 Dec 2003 18:07:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprztlvdeyq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'd like to be able to query the capabilities (number of channels, buffer=
=20
size etc.) of ALSA devices in the system, even if they should be in use b=
y=20
some other process. The only current way to probe device capabilities is=20
to open a pcm, and use snd_pcm_hw_params, correct? At least this is my=20
current approach, but I'd like to query the devices without first=20
acquiring exclusive access. If there is currently no way around acquiring=
=20
a device for querying, maybe this requirement could be loosened in a=20
future version of ALSA?

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
