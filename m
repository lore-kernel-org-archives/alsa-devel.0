From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Fri, 4 Apr 2003 13:46:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030404114623.GB9836@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <20030331114752.GA3187@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030331114752.GA3187@wotan.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. Werner Fink" <werner@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 31, 2003 at 01:47:52PM +0200, Dr. Werner Fink wrote:

> Hmmm ... I've put some lines into cmipci.c to support setting of
> the seconf/third status bits within the 2*192 status bits of
> the S/P-DIF stream for supporting none audio data PCM streams
> (with this it should also possible to support 20 or 24 bits per
> PCM word) -> See USE_AES_IEC958 cpp macro in cmipci.c.
>=20
> IMHO this way should be possibel for all sound chips which are
> not able to provide a hardware setup of the status bits of the
> S/P-DIF stream but able to put out raw data (e.g. 32 bit S/P-DIF
> words) with doubled sample clock onto the S/P-DIF out plug.

Hello again,

sorry to ask again :-(
I have just installed latest alsa CVS of drivers,lib and utils and still
get a:

pr  4 13:37:43 localhost vdr[20035]: S/P-DIF: Period size not available: =
Invalid argument
Apr  4 13:37:43 localhost vdr[20035]: S/P-DIF: unable to establish BitStr=
eamOut for none audio PCM=20
Apr  4 13:37:43 localhost vdr[20035]: REPLAY: can't open spdif interface

Should I change anything anywhere?
Or buy a card with cmipci? (Well I like the Digifire 7.1 I have now,
which has also an integrated Firewire...).

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
