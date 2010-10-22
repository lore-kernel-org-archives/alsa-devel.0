From: "Juliano F. Ravasi" <ml@juliano.info>
Subject: Re: [alsa-devel] hda-intel (ALC889) - sound
 loops/repeats continuously, and general brokenness
Date: Fri, 22 Oct 2010 11:55:10 -0200
Message-ID: <4CC197BE.2000706@juliano.info>
References: <4CBF45C0.5060903@juliano.info> <4CC05F15.4000101@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <4CC05F15.4000101@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2010 01:41 PM, Clemens Ladisch wrote:
> Please check in /proc/interrupts whether that interrupt actually
> works.

There is no interrupt at all being assigned to hda_intel.

Yesterday, all of a sudden, the problem fixed itself and everything
about this driver started working as expected. I restarted the driver to
be sure and all problems returned. Then I noticed these two lines in the
log at the time when the problem fixed itself:

hda-intel: No response from codec, disabling MSI: last cmd=3D0x20cb2001
hda_intel: azx_get_response timeout, switching to single_cmd mode: last
cmd=3D0x20cb2001

So, I added to my modprobe.conf:

	options snd-hda-intel enable_msi=3D0 single_cmd=3D1

And now everything works fine and there is an hda_intel line in
/proc/interrupts. I don't know what are the implications of these
parameters. Particularly single_cmd seems to flag an incorrect operation
of the driver. Perhaps the driver should detect and blacklist this card
from MSI?

Thank you very much for your help!

Regards,
Juliano.


-- =

Juliano F. Ravasi =B7=B7 http://juliano.info/
5105 46CC B2B7 F0CD 5F47 E740 72CA 54F4 DF37 9E96

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
