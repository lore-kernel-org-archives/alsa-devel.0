From: Nikhil Deo <nikhil_deo@usa.net>
Subject: Re: [Re: Configuring the mixer]
Date: Wed, 28 Apr 2004 17:17:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <508iDbVRd8672S02.1083187049@uwdvg002.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just wanted to mention that I was able to do this yesterday <grin>. I had=
 to
find all the mixer groups. Their params told me that only Mic-In was bein=
g
captured, both channels. If I started capturing both channels of Line-In,=
 I
could not capture Mic-In at all as mentioned by clemens. But to my deligh=
t I
could capture left channel of Line-In and right channel of Mic-In by
configuring the appropriate Mixer group structure's 'capture' element pro=
perly
and send it to the mixer and it came out Line-out on the required channel=
s
respectively. =


Now I am off to my next step: trying to separate the left and right chann=
el
data from a buffer that I have captured/read. If you have not figured out=

already, I am trying to use an echo cancellor and after I separate out th=
is
left and right channels I would feed it to the echo-can software. =


Any idea how the captured buffer stores the different channels that I nee=
d to
extract?

Thanks in advance. =



 =


Clemens Ladisch <clemens@ladisch.de> wrote:

> Nikhil Deo wrote:
> > It is to be done on QNX
> =

> By now, QNX's API is completely different.
> =

> > I need to capture input from the mic AND the line in.
> =

> This will work only if your hardware supports this.  Many sound cards
> can select exactly one input for recording.
> =

> > Then I need to output the mic input on the Right-LineOut and
> > leftLineIn on leftLineOut. (right line in can be ignored)
> =

> This is easy once you have captured the data.
> =

> =

> Another possibility would be to configure the mixer to route the
> inputs as you want them.  Again, this is dependent on the capabilities
> of your hardware/drivers.
> =

> > in 2, my mixer group was input gain and although it seemed to be
recording
> > something, I could not figure out what it was. How do I make it take =
the
input
> > from  mic in only?
> =

> In ALSA, most cards have a mixer control "Capture Source" which allows
> to select between several input.  Some cards have "Capture Volume"
> controls for each input and mix all together.
> =

> =

> HTH
> Clemens
> =

> =

> =

> =

> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=3D12297
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> =






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
