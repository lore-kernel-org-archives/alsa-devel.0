From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 8 Apr 2003 22:44:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408204425.GA6940@ulima.unil.ch>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <20030408164241.GA4253@ulima.unil.ch> <3E933167.6010300@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E933167.6010300@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 08, 2003 at 09:30:31PM +0100, James Courtier-Dutton wrote:

> On my SB Live, with AC3 I use: -
> PCM device "iec958:AES0=3D0x6,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2"
>=20
> On your example AES0=3D0x0, whereas I have AES0=3D0x6.
> It is AES0 which sets the non-audio bits in the SPDIF.

Exactly, it's what I also got with other option to obtain ac3...
I have tested lots of option (and other users also have, as reported to
this list) and with ac3 receivershich uses the bit flags of the S/P-DIF
transport stream for identifying none audio loose :-(
Of course I only speak for cs46xx.

Either no sound, or only cliking sound...

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
