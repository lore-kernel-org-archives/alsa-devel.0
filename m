From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: Mo' better modem support
Date: Wed, 07 Sep 2005 19:03:43 +0300
Message-ID: <20050907160343.GA3375@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de>
 <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h8xyauxxr.wl%tiwai@suse.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jacques.Goldberg@cern.ch, marvstod@comcast.net
List-Id: alsa-devel@alsa-project.org

[ I CC: to linmodems people ]

On 15:29 Tue 06 Sep     , Takashi Iwai wrote:
> At Tue, 06 Sep 2005 02:29:51 +0300,
> Sasha Khapyorsky wrote:
> > 
> > > and found out the
> > > following problems:
> > > 
> > > 1. Off-Hook switch needs manually turned on
> > 
> > Yes. I think that it is ok, this should be controlled separately from
> > PCM. For instance for Caller ID polling we will need to run capturing
> > with CID switch 'on' and Off-Hook switch 'off'. Other example is typical
> > dialer (auto-dialer or so), this will turn 'Off-hook' switch 'on', start
> > playback (to send DTMFs), stop playback and leave line with 'Off-hook'
> > is 'on'.
> > 
> > >    Shall we add a hook in pcm.modem definition for this control?
> > 
> > If we really need to auto-"Hoof-Off" we may separate it to logically
> > different pcm devices (like pcm.modem, pcm.phoneline or so) and then add
> > hook to one of them.
> 
> Sounds reasonable.

I will prepare patch this weekend or so (want to test it first).

> > ( But really, who will use it? Specialized phone oriented application
> > (like dialer, voice machine or softmodem) will control DAA specific
> > switches explicitly anyway. And for simple scripting amixer + aplay
> > should be good enough. )
> 
> I don't know how many its demand is.  But, I guess 99% is only the
> modem, and adding this hook to pcm.modem would suffice, right?

No, the modem application needs explicit "Hook-Off" control, just as was
in my example it may poll the line for Caller ID detection with
"Hook-Off" turned off (and few more usage cases).

But OTOH it is not big deal to handle this control explicitly even with
auto-"Hook-Off"ed device or to use alternative "raw" device - can live
with it.

> All what I want among these is just an easy-to-use set up.
> 
> > > 2. All controls have index 1, thus the appearance on alsamixer looks
> > >    strange
> > 
> > Will see it (no modems near me).
> 
> This is because ac97.num=1.  It's correct from the driver's POV,
> but a bit nasty from user's POV.
> 
> > > 3. There is no way to detect the modem driver from sysfs or so.
> > 
> > There is no some "standard" way to define softmodem in Linuxi - remember
> > this "winmodem is not modem", and this is correct. What we actually have
> > in hardware (and in ALSA) is not modem, it is simplified sound codec +
> > Data Access Arrangement (DAA) (aka Telephone Line Interface Circuit).
> > And the "real" modem (which performs modulation/demodulation) is
> > user-space application (like proprietary 'slmodem') that uses the
> > standard ALSA api to communicate with this sound device.
> > 
> > ( don't mention here binary-only kernel modem drivers provided by some
> > vendors. )
> 
> Yes, I agree.  Let's reword it as "softmodem codec", then.
> The purpose of these devices are different from "audio",

Not fully agree. The purpose is different on level of "what we are going
to do with it" - user-decision. We may just play sounds with softmodem
codec (voice machine is example) and probably to use sound card for data
modulations (as done by 'soundmodem' iirc). Technically there is same
purpose - to play and record sounds.

> so definitely
> we need some distinction, which is visible from outside.

Agree that we need some distinction (probably cosmetic) to simplify
usage, just because "typical" application will use audio and modem
devices for different purposes, but "raw" level I would prefer to save
as is.

BTW how about SND_PCM_CLASS_? It is not used today, but it may serve
our purpose.

> 
> > >    Espeically, hda-intel driver supports both audio and modem by a
> > >    single driver, and the modem support doesn't appear even on proc
> > >    file explicitly.
> > 
> > Agree, 'proc' files will be helpful with MFG too. Actually I've planned
> > to do it, but don't have HDA hardware now. Testers?
> > 
> > (BTW one more reason why it will be helpful: existed HDA modem driver
> > has just one (known) vendor ID, but I guess there will be more same chip
> > based modems with different vendor IDs. If we will show this info
> > somewhere in proc files it will simplify IDs addition)
> 
> I think it's another variable of hda_proc.c for MFG.  Currently it
> shows only the AFG trees.
> 
> What I thought is a universal proc or sysfs interface indicating modem
> codecs.

Good idea.

> Main purpose is the auto-detection of available devices by
> the installer.  In the case of PCI, it can be detected by the PCI
> class id. 

Generally it is not very good method. Even if PCI class ID is defined
correctly it is hard to know kind of modem: hardware/"real",
winmodem/"controless" or softmodem.

(BTW what "correctly" should be there? PCI_CLASS_COMMUNICATION_MODEM? -
then serial driver will try to initialize it as serial port, but there
is no serial port.)

> But HDA-modem, currently it's not possible to know before
> the driver is loaded...

Yes, and same problem exists with come AC97 devices (ALi M5451 for
example) - modem detection is not user-friendly procedure (linmodems
people know this very well).

What we may do is to load the driver according to PCI IDs and then
check appropriate info with "universal modem indicating" interface
above. Agree with it. Will see as well.

> > > Well, 2 is a minor problem, and we can live with that.
> > > But others should be improved...
> > >
> > >
> > > Any ideas?
> > 
> > Some more things for your list:
> > 
> > 4. Unsupported Conexant modem codecs (AC97 and HDA).
> 
> Yep.  That'll be really nice to have (iff conexant gives us the h/w
> detail... :)
> 
> > 5. Lack of incoming call notifications.
> > 6. Lack of free softmodem software.
> 
> Yeah :)  This would be a legally tough negotiation...

Sure :) . But I don't think about negotiations (too hard imho), probably
we could to develop one (or at least to try).

Sasha.

> 
> > '5' may be related to '3', but I think this is more generic problem:
> > is there "standard" telephony interface (or just used by nobody
> > 'include/linux/telephony.h')?
> 
> AFAIK, only ixj (and ixj-pcmcia) driver uses this interface.
> 
> 
> Takashi
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
