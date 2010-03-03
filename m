From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Wed, 3 Mar 2010 12:02:48 +0200
Message-ID: <201003031202.48598.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267596472.24345.16.camel@eenurkka-desktop>
	<20100303090324.83d076b6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 838DF24422
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 11:02:59 +0100 (CET)
In-Reply-To: <20100303090324.83d076b6.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 March 2010 09:03:24 ext Jarkko Nikula wrote:
> On Wed, 03 Mar 2010 08:07:52 +0200
> =

> Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:
> > Mostly the samples were good (49/50, @48khz, 2 channels, value polled
> > from userpace), but the remaining 1/50 were garbage - and actually
> > matched the probability of a simultaneous DMA burst.

Yeah, but you can place the same argument for the DMA pointer as well:
If you read the pointer in a right time (very close to the start of the bur=
st), =

than you have the same problem, since after few usec the DMA pointer will b=
e at =

the end of the period, right?

> > So the problem is -
> > if you read at time t0, and the DMA burst is taking place at the same
> > time - you get a value that looks rather random, as when (if) you poll
> > the position @ t0 + n uS, the value is (after some usecs) a lot
> > different. Or maybe the XBUFFSTAT just isn't reliable at all (regardless
> > of DMA bursts etc).

Yes, the XBUFFSTAT is not that reliable, it shows the buffer state at the l=
ast =

L4 clock phase. If the diff between the L4 speed and the audio is big enoug=
h, =

than you will have old data in the register, which does not reflect the rea=
lity. =

As far as I understand.

> =

> Yeah, that's interesting to find out are the XBUFFSTAT reading
> differences inside the DMA burst size or distributed completely
> randomly. I think the XBUFFSTAT should increase at the sample rate and
> decrease or jump down fast when the DMA burst takes place.

Anyhow, I have done few tests (McBSP2):
printing XBUFFSTAT before trigger:start
printing XBUFFSTAT right after trigger:start
printing XBUFFSTAT at the pointer call time
print at DMA interrupt
printing XBUFFSTAT before trigger:stop
printing XBUFFSTAT right after trigger:stop

The command for test:
aplay -fdat -d 1 /dev/urandom

In element mode:
[   96.211364] Start 01
[   96.213592] XBUFFSTAT: 1280  # before omap_mcbsp_start
[   96.216918] XBUFFSTAT: 0     # after omap_mcbsp_start
[   96.219451] Start 02
[   96.244415] XBUFFSTAT: 0     # at pointer.
[   96.246978] XBUFFSTAT: 0
[   96.249542] XBUFFSTAT: 0
[   96.253265] XBUFFSTAT: 0
[   96.255859] XBUFFSTAT: 0
[   96.259033] XBUFFSTAT: 0
[   96.261596] XBUFFSTAT: 0
[   96.264404] XBUFFSTAT: 0
[   96.267791] XBUFFSTAT: 0
[   96.270324] XBUFFSTAT: 0
[   96.272888] XBUFFSTAT: 0
[   96.276458] XBUFFSTAT: 0
[   96.279022] XBUFFSTAT: 0
[   96.282165] XBUFFSTAT: 0
[   96.284729] XBUFFSTAT: 0
[   96.287536] XBUFFSTAT: 0
[   96.290924] XBUFFSTAT: 0
[   96.293487] XBUFFSTAT: 0
[   96.296020] XBUFFSTAT: 0
[   96.299774] XBUFFSTAT: 1
[   96.302459] XBUFFSTAT: 0
[   96.305847] XBUFFSTAT: 0
[   96.308471] XBUFFSTAT: 0
[   96.311035] XBUFFSTAT: 0
[   96.314666] XBUFFSTAT: 0
[   96.317230] XBUFFSTAT: 0
[   96.319793] XBUFFSTAT: 0
[   96.323150] XBUFFSTAT: 0
[   96.325744] XBUFFSTAT: 0
[   96.328399] DMA              # DMA interrupt
[   96.330169] XBUFFSTAT: 0     # at pointer.
...
[   97.201904] DMA
[   97.203704] XBUFFSTAT: 0
[   97.206237] Stop 01
[   97.208343] XBUFFSTAT: 203   # before omap_mcbsp_stop
[   97.211090] XBUFFSTAT: 1280  # after omap_mcbsp_stop
[   97.213897] Stop 02

So the buffer is kept full in element mode, as it is expected.

Now the interesting thin is in threshold mode (threshold =3D 1023):
[  288.093475] Start 01
[  288.095703] XBUFFSTAT: 1280  # before omap_mcbsp_start
[  288.099029] XBUFFSTAT: 257   # after omap_mcbsp_start (257+1023=3D1280),=
 OK
[  288.101745] Start 02
[  288.104003] DMA
[  288.105773] XBUFFSTAT: 904
[  288.108520] DMA
[  288.110260] XBUFFSTAT: 311
[  288.117706] XBUFFSTAT: 1024
[  288.120513] DMA
[  288.122283] XBUFFSTAT: 442
[  288.127929] XBUFFSTAT: 982
[  288.130645] DMA
[  288.132415] XBUFFSTAT: 391
[  288.137969] XBUFFSTAT: 923
[  288.140686] DMA
[  288.142456] XBUFFSTAT: 331
[  288.147796] XBUFFSTAT: 844
[  288.150573] DMA
[  288.152343] XBUFFSTAT: 257
[  288.157867] XBUFFSTAT: 787
[  288.160614] DMA
[  288.162384] XBUFFSTAT: 196
[  288.168395] XBUFFSTAT: 774
[  288.171142] DMA
[  288.172912] XBUFFSTAT: 183
[  288.178466] XBUFFSTAT: 717
...
[  288.565612] DMA
[  288.567382] XBUFFSTAT: 182
[  288.572509] XBUFFSTAT: 673
[  288.576263] DMA
[  288.578033] XBUFFSTAT: 181
[  288.583007] XBUFFSTAT: 659
[  288.586944] DMA
[  288.588714] XBUFFSTAT: 182
[  288.597595] DMA
[  288.599365] XBUFFSTAT: 182
[  288.608245] DMA
[  288.610015] XBUFFSTAT: 182
[  288.618896] DMA
[  288.620697] XBUFFSTAT: 182
[  288.629577] DMA
[  288.631347] XBUFFSTAT: 182
[  288.640228] DMA
...
[  289.077331] DMA
[  289.079101] XBUFFSTAT: 182
[  289.087982] DMA
[  289.089752] XBUFFSTAT: 181
[  289.092498] Stop 01
[  289.094604] XBUFFSTAT: 646   # before omap_mcbsp_stop
[  289.097320] XBUFFSTAT: 1280  # after omap_mcbsp_stop
[  289.100128] Stop 02

These numbers were in a same range (variation was around 10) among several =

rounds.
Looking at the numbers, I think they are kind of sane.
After DMA interrupt the buffer has more data than a bit later, when the poi=
nter =

is called (McBSP played out samples).
One thing that I don't really understand is in the second block: suddenly w=
e =

have only one pointer call in response to snd_pcm_period_elapsed(substream)=
; =

while earlier we had one extra pointer call...

let's take one part out:
[  288.160614] DMA
[  288.162384] XBUFFSTAT: 196
[  288.168395] XBUFFSTAT: 774

If application would write a sample at 288.162384, than it will be played o=
ut =

after 542 stereo samples [(1280 - 196 =3D 1084) / 2].
If application would write a sample at 288.168395, than it will be played o=
ut =

after 253 stereo samples [(1280 - 774 =3D 506) / 2].
The difference between these in samples: 542 - 253 =3D 289
The time difference is: 288.168395 - 288.162384 =3D 0.006011
In 0.006011 seconds at 48KHz the number of samples played out is 288.528

So according to XBUFSTAT we have played out 289 samples.
based on the time we actually played 288.528 samples.

I would say this is really close to what we would expect to have?

Note: I have used printk for these, which pretty much alters the behavior a=
 bit =

in timing wise...

-- =

P=E9ter
