From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: New azx driver: Problems in snd_mixer_load
Date: Thu, 9 Dec 2004 15:26:39 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE16F@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote:
> On top of this, I added the latest CVS version of the azx=20
> driver into the kernel.

I think I've found half of the problem... I identified the codec chip on
the board, and it's a CMI9880, which isn't explicitly handled by the azx
driver, so it falls through to the default. I don't know why the default
doesn't work, but anyway...

I did find a spec for the codec - it seems to have all the relevant
information that's equivalent to the tables in patch_realktek.c, so I
guess one could create a complete driver from this. I took a look at it,
and am not quite sure how to proceed though, since I'm not remotely
familiar with the internals of HDA.

http://www.cmedia.com.tw/doc/C-Media%20CMI9880%20Datasheet%20rev%200.99C
.pdf

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
