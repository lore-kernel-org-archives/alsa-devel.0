From: "Cody Jung" <funkycat32@gmail.com>
Subject: Re: [alsa-devel] ALSA Newbie - Getting Ensoniq
	SoundscapeVivo to work? [Solved]
Date: Sun, 29 Apr 2007 16:18:25 -0500
Message-ID: <d382e1990704291418x20550cc7l17239562227f2a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 4/29/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 04/29/2007 09:31 AM, Rene Herman wrote:
>
> > I've attached (to try and avoid linewrap) the lines that you will need in
> > /etc/modprobe.conf.
>
> No I haven't.
>
> Rene.
>
> alias           snd-card-0      snd-cs4231
> alias           sound-slot-0    snd-cs4231
>
> options         snd-cs4231      index=0 port=0x534 irq=5 dma1=1 dma2=0
>
> install         snd-cs4231      echo activate >/sys/bus/pnp/devices/01\:01.00/resources &&\
>                                 sleep 1 &&\
>                                 /sbin/modprobe --ignore-install snd-cs4231
>
> remove          snd-cs4231      /sbin/modprobe -r --ignore-remove snd-cs4231 &&\
>                                 echo disable >/sys/bus/pnp/devices/01\:01.00/resources
>
>

Wahoo! Thank you, thank you!

I ended up not going the /etc/modules way, partially because it wasn't
working and partially because I didn't know what I was doing. Instead
I added the following 4 lines to a file and included it in my init
scripts.

echo activate > /sys/bus/pnp/devices/01\:01.00/resources
sleep 1
modprobe snd
modprobe snd-cs4231 port=0x534 irq=5 dma1=1 dma2=0

And it works great!

Thanks again for putting up with my incompetence.
~Cody Jung

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
