From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Re: Bug in serial-u16550.c
Date: Mon, 07 Mar 2005 10:53:40 -0000
Message-ID: <opsm9kjq1un0kn27@linux.site>
References: <Pine.HPX.4.33n.0502241331070.300-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.HPX.4.33n.0502241331070.300-100000@studcom.urz.uni-halle.de>
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

On Thu, 24 Feb 2005 13:48:24 +0100 (MET), Clemens Ladisch =20
<clemens@ladisch.de> wrote:

> Bill Adair wrote:
>> There is a bug in serial-u16550.c that has been causing my PC to lock =
up
>> solid. The three chunks of code
>> should explain the nature of it. Basically a lock is taken out on
>> interrupt and is still held on calling
>> snd_rawmidi_receive (). snd_rawmidi_receive () eventually calls back =20
>> into
>> the driver code at snd_uart16550_input_trigger ()
>> where an attempt is made to take out the same lock again. Other pieces=
 =20
>> of
>> code using the same construction avoid
>> this problem by unlocking before calling snd_rawmidi_receive () and
>> relocking e.g. mtpav.c - though this does
>> not seem a good solution ;-).
>
> This depends on what data the lock is supposed to protect.
>

The different flags used in filemode are below. There are all seperate =20
bits of a bitfield i.e.
setting SERIAL_MODE_INPUT_TRIGGERED cannot effect SERIAL_MODE_INPUT_OPEN.=
 =20
The only flag
ever tested in the driver is SERIAL_MODE_INPUT_OPEN, the others are just =
=20
set.

So as it happens the code does nothing at all except - as a by blow - =20
check that a lock
can be taken out on the uart structure (which is can't because it's =20
already locked).

>> Do you want a patch for this? In the Opcode driver I've been writing
>> based on this I've checked to see if the kernel is in an interrupt usi=
ng
>> the in_interrupt ()
>> call before locking or unlocking in snd_uart16550_input_trigger ().
>
> Not locking could, in theory, lead to problems on SMP machines.
>

Locking against an already held lock is problematical on my machine ;-).
My machine is SMP and from my reading of the kernel programming guides =20
when an interrupt is
received it is _guaranteed_ to be serviced on the processor it was picked=
 =20
up by. Presumably
this would include the alsa code executed until the interrupt is marked a=
s =20
serviced.

> However, it filemode is the only variable that is protected, it might
> be possible to change it to use atomic bit operations.
>

Have you a sample of code for this?

>> Can anyone describe the function of the up parameter passed to
>> snd_uart16550_input_trigger ()?
>
> It enables/disables input from the port.
>

This is interesting - can the sequencer code in alsa tell the driver not =
=20
to accept further
input? There is no support in this driver for this if that is the case.

>> Should I be using this to determine if the call came from an interrupt=
?
>
> It has nothing to do with in-interruptness.
>
>
> HTH
> Clemens
>

#define SERIAL_MODE_NOT_OPENED          (0)
#define SERIAL_MODE_INPUT_OPEN          (1 << 0)
#define SERIAL_MODE_OUTPUT_OPEN         (1 << 1)
#define SERIAL_MODE_INPUT_TRIGGERED     (1 << 2)
#define SERIAL_MODE_OUTPUT_TRIGGERED    (1 << 3)

static void snd_uart16550_input_trigger(snd_rawmidi_substream_t =20
*substream, int up)
{
         unsigned long flags =3D 0;
         snd_uart16550_t *uart =3D substream->rmidi->private_data;

         if (!in_interrupt ()) {
                 spin_lock_irqsave (&uart->open_lock, flags);
         }
         if (up) {
                 uart->filemode |=3D SERIAL_MODE_INPUT_TRIGGERED;
         }
         else {
                 uart->filemode &=3D ~SERIAL_MODE_INPUT_TRIGGERED;
         }
         if (!in_interrupt ()) {
                 spin_unlock_irqrestore (&uart->open_lock, flags);
         }
}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
