From: "Peter Heatwole" <peter599@gotnet.net>
Subject: Re: AC3 passthru intel8x0 + cs4299
Date: Sun, 23 Feb 2003 11:30:24 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0678cda04ef54f77bc3903420baacd97.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Zierath Bernd <B.Zierath@ebv.com>
List-Id: alsa-devel@alsa-project.org

Zierath Bernd wrote:
> AC3 passthru on the cs4299 is not implemted right now, is anyone on the li=
st
> willing to help=2E

   Another question: do you have to be able to access the IEC958 directly to=

send AC3 to it?  Currently the cs4299, cs4297a, and the cs4294 merely copy t=
he
playback data to the IEC958 port, without direct access=2E  Could you simply=
 power
down the playback SRC and the DAC, send data to the card, and let the codec =
copy
the unmodified steram to the IEC958 output as usual, allowing an AC3 stream =
to be
sent to an external decoder?
   I realize there may be timing and other issues involved, I'm only asking =
this
from a theoretical standpoint

-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
