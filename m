From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Sun, 13 Apr 2003 19:05:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030413170501.GA2323@ulima.unil.ch>
References: <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk> <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch> <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E994CCE.6020105@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 13, 2003 at 01:41:02PM +0200, Benny Sjostrand wrote:

> Gregoire:
> Please dont give up yet, could you test the atached patch to current CV=
S.
> Then test out different values on the=20
> "AES0=3D0x0,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2" parameters like:
> "AES0=3D0x2,AES1=3D0x0,AES2=3D0x82,AES3=3D0x0",
> "AES0=3D0xFF,AES1=3D0xFF,AES2=3D0xFF,AES3=3D0xFF",
> "AES0=3D0x00,AES1=3D0x00,AES2=3D0x00,AES3=3D0x00"  (and any other
> values that cames into your mind ... )

Hello,

I'll test as many patches as you'll write ;-)

I have patched my CVS with your patch, then made a
./cvscompile --with-sequencer=3Dyes --with-cards=3Dcs46xx --with-isapnp=3D=
no
and sudo make install

And afterthat as root a /etc/init.d/alsasound restart
Then a lots of
ac3dec file.ac3 --device=3Diec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D=
0x2
5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
Using PCM device 'iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'

All are playing the file in 2.0 mode, and all test I have done with xine
don't work neither...
Same problem with mplayer (xine and mplayer: either no sound or just the
clicking sound).

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
