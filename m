From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 8 Apr 2003 18:42:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408164241.GA4253@ulima.unil.ch>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hn0j1q97r.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 08, 2003 at 05:50:48PM +0200, Takashi Iwai wrote:

> i'm afraid that it's not so easy as it sounds.  it strongly depends
> on the hardware driver implementation...
>=20
> about AC3, 32bit spdif is likely irrelevant.  A52 (AC3) is usally
> packed into normal 16bit frames.
>=20
> does the click happen even if you use alsa-tool's ac3dec?

Yes and no:

./ac3dec -C /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3 don't
produce any sound at all now... except ONE big click at the beginning,
same with -P and
./ac3dec -R /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3
5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
Using PCM device 'iec958:AES0=3D0x0,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'

Produces also the same big click and then plays quiete good (only 2.0 no
dolby digital is sent to the receiver...).

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
