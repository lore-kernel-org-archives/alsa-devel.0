From: Gustavo Guillermo <gustavo@compunauta.com>
Subject: Re: via82xx: DXS channels
Date: Wed, 14 Jan 2004 01:22:24 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040114.1222400.1840468218@linux.local>
References: <20040112223351.GA8592@onion.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040112223351.GA8592@onion.home.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Timo Hirvonen <tihirvon@ee.oulu.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I will test it. for A7v8X-X

>>>>>>>>>>>>>>>>>> Mensaje original <<<<<<<<<<<<<<<<<<

El 13/01/04, 4:33:51, Timo Hirvonen <tihirvon@ee.oulu.fi> escribi=F3 sob=
re el=20
tema [Alsa-devel] via82xx: DXS channels:


> Hi!

> I tested DXS channels of my via82xx chip.  My motherboard is ASRock
> K7VT2 and the kernel is 2.6.1-mm2.

> With dxs_support=3D1 option DXS channels did not work (bad sound quali=
ty)
> but they did with dxs_support=3D4.

> I noticed the volume ranges for DXS channels are wrong (0-255),
> should be 0-31.  Here is a patch which fixes the problem and adds
> ASRock K7VT2 to the dxs_whitelist.  I don't know if this works on othe=
r
> motherboards!

>    Timo


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
