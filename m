From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] USB card @48kHz only: at what layer	to
	resample?
Date: Sun, 24 Sep 2006 13:02:16 -0400
Message-ID: <1159117337.2899.12.camel@mindpipe>
References: <J63VP2$431C1B7FE9E7D40917996C0B2EBE87B8@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <J63VP2$431C1B7FE9E7D40917996C0B2EBE87B8@libero.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "enrico_groups@libero.it" <enrico_groups@libero.it>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, mrechberger <mrechberger@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-09-24 at 18:41 +0200, enrico_groups@libero.it wrote:
> Thanks Markus and all for the replies.
> 
> My problem is that STK does not seem able to see the alsa plugins.
> 
> In other words, when one uses -say- aplay it is possible to specify what device or plugin to use with the -D option, for example:
> -D plug:duplex
> as you suggest in the example.
> 
> In the STK api for alsa I can only select one of the audio cards, in my case I see the following 4:
> 
> hw:I82801CAICH3,0
> hw:I82801CAICH3,1
> hw:U0x4710x311,0
> hw:Audio,0
> 
> The first two seem to be related to the built-in laptop sound card (intel chip based) (why 2 entries???)

Probably analog and SPDIF.

> , the third one is probably the mic input of the webcam and the last one is my terratec.
> I can only select one of these by number (i.e. I can select 1, 2, 3 or 4)
> 

This is an incorrect use of the ALSA API by STK (It doesn't help that
ALSA has no good device enumeration API).  It should allow you to choose
plughw:* devices, but it only lists hw:* devices.  This means that only
sample rates supported by the hardware can be chosen.

> If I try to open the last one at 44.1kHz I get: 
> RtApi: unable to open specified device(s) with given stream parameters:
>     RtApiAlsa: error setting sample rate (44100) on device (hw:Audio,0): Invalid argument.
> 
> If I open it at 48kHz it is fine.
> 
> In general, from the discussion I understand that the best (but probably long term for me) solution is to change my code to work at 48kHz, but for now it's really important to get the old code to work. 
> 

You just need to patch STK to allow plughw devices to be used, or give
up and run at 48Khz.  There's no other solution.

> Does this make any sense?
> Any suggestions?
> 
> Thanks,
> Enrico
> 
> ---------- Initial Header -----------
> 
> >From      : "Markus Rechberger" mrechberger@gmail.com
> To          : "enrico_groups@libero.it" enrico_groups@libero.it
> Cc          : "alsa-user" alsa-user@lists.sourceforge.net,"alsa-devel" alsa-devel@lists.sourceforge.net
> Date      : Sun, 24 Sep 2006 16:32:23 +0200
> Subject : Re: [Alsa-devel] USB card @48kHz only: at what layer to resample?
> 
> 
> 
> 
> 
> 
> 
> > Hi,
> > 
> > you could use the alsa rate plugin.
> > 
> > I used following .asoundrc for testing my driver:
> > 
> > pcm.au600playback {
> >         type dmix
> >         ipc_key 1024
> >         ipc_perm 0777
> >         slave {
> >                 pcm "hw:2,0"
> >                 period_time 0
> >                 period_size 96
> >                 buffer_size 1920
> >                 format S16_LE
> >                 periods 4
> >                 rate 9600
> >         }
> > }
> > 
> > pcm.au600capture {
> >         type rate
> >         slave {
> >                 pcm "hw:2,1"
> >                 format S16_LE
> >                 rate 9600
> >         }
> > }
> > pcm.duplex {
> >         type asym
> >         playback.pcm "au600playback"
> >         capture.pcm "au600capture"
> > }
> > 
> > aplay -D plug:duplex <filename>
> > 
> > cheers,
> > Markus
> > 
> > On 9/24/06, enrico_groups@libero.it <enrico_groups@libero.it> wrote:
> > > Dear All,
> > >
> > > Apologies in advance if I am asking a stupid question, I am quite new with
> > > alsa.  I posting to both lists because I am not sure about handling this
> > > issue at the application development level or at the alsa driver
> > > configuration level.
> > >
> > > I am developing an audio application using the CCRMA synthesis tool-kit
> > > (STK) in Fedora Core4 using alsa.  I recently bought a Terratec Aureon 5.1
> > > USB MKII card, because I needed to have better sound quality than what
> > > offered by my laptop.
> > >
> > > My understanding is that the usb card only works at 48kHz -- is this
> > > correct?
> > > I manage to get aplay to work using the following plugin in /etc/asound.conf
> > > pcm.!default {
> > >     type plug
> > >     slave {
> > >         pcm "hw:2,0"
> > >         rate 48000
> > >     }
> > > }
> > >
> > > However, in SKT I can enumerate the audio cards on my machine, but this does
> > > not give me alsa plugins, only the audio cards.  If I try to open the Aureon
> > > at 44.1kHz, I get an error saying rate not supported.
> > >
> > > Is there any way to have alsa handle the rate conversion for me?  Shouldn't
> > > or couldn't the driver take care of this?  (Was it my mistake in installing
> > > the driver? I can post my /etc/modprobe.conf if it helps)
> > > Or is there any way to get STK to see the plugin?
> > >
> > > Thank you in advance,
> > > Enrico
> > >
> > >
> > >
> > >
> > >
> > > -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to share your
> > > opinions on IT & business topics through brief surveys -- and earn cash
> > > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > >
> > 
> > 
> > -- 
> > Markus Rechberger
> > 
> 
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
