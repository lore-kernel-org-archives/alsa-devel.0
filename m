From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Re: New driver for Opcode 64X Serial MIDI interfaces
Date: Mon, 07 Mar 2005 11:07:02 -0000
Message-ID: <opsm9k50ikn0kn27@linux.site>
References: <Pine.HPX.4.33n.0502241352040.300-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.HPX.4.33n.0502241352040.300-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Feb 2005 14:12:17 +0100 (MET), Clemens Ladisch =20
<clemens@ladisch.de> wrote:

> Bill Adair wrote:
>> Do you want me to (a) provide a replacement file for
>> serial-u16550.c, (b)  provide a version of serial-u16550.c with
>> comment documentation in but no Opcode driver and a seperate
>> Opcode driver file, or (c) provide just a comment documented
>> Opcode driver and leave serial-u16650.c alone?
>
> If the Opcode is similar enough to other serial devices (BTW: what are
> the differences?), there's no reason to put it into a separate file.
>
> Please submit one patch for each logically independent change.
>
>
> Regards,
> Clemens
>

The Opcode device is similar to the others in that it uses F5 for channel=
 =20
changing.
The major differences are it's relative modernity and therefore throughpu=
t =20
speed
(the device runs at 115200 baud), the sign on sequence demanded by the
interface before allowing any midi traffic, a sign off sequence required =
=20
at the end
of use, and the signalling required to prevent midi traffic choking. Ever=
y =20
four bytes
sent to the interface the computer must wait for a _toggle_ of CTS (there=
 =20
is nothing like
this in the current drivers) and every 16 bytes sent to the pc the =20
interface waits for a
_toggle_ of RTS. The device can also be indentified as being on the seria=
l =20
port which the
driver does (instaed of just checking for a UART chip).

Bill



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
