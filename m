From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
 (Summary)
Date: Sun, 28 Sep 2003 21:41:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F77395B.8080208@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com> <s5h7k4snyhl.wl@alsa2.suse.de> <3F539A3E.3030508@icem.com> <3F53B38B.6070307@icem.com> <3F75D029.60502@icem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F75D029.60502@icem.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I forgot two more things:

1) If there is anything else you would like me to try out or any
    additional information from that system, I will be glad to help.

2) Is anyone else having similar problems?
    Is it just me or do other nforce2 users also have the feeling
    that Alsa supports IEC958 much, much better on the CMI8738
    than on nforce2?

Thanks again and Cheers,

Carsten.



Carsten Koch wrote:
> Hi,
> 
> here is a summary of my adventures with Alsa sound through SPDIF
> on my Abit NF7 nforce2 main board.
> 
> First I want to thank Takashi and James for their friendly and
> sedulous help.
> Without them, I would have gotten no sound to work through the SPDIF
> output at all.
> 
> In the end, we got almost everything to work, except for the loop-through
> from SPDIF in to SPDIF out. Unfortunately, this is a requirement
> for me, so I gave up and now installed an additional C-Media PCI CMI8738
> sound card on my PC, which works perfectly right out of the box.
> 
> In particular, with the C-Media PCI CMI8738, alsamixer provides me
> with a "IEC958 Loop" switch, which I need to loop the digital sound
> output of my DVB card to the sound card output which is connected
> to my HiFi equipment.
> 
> Other things that I find *much* user-friendlier about Alsa with the
> CMI8738 compared to Alsa with the on-board nforce 2 sound include:
> 
> *  The CMI8738 default device (hw:0.0) plays through both the
>    analog output and the SPDIF output at the same time. No need
>    to tweak defaults through a .asoundrc file.
>    The nforce2 default device (hw:0.0) only plays through the
>    analog output.
> 
> *  All programs I tested (mpg123, alsaplayer, mpg321, kde desktop
>    sound) simply worked with the CMI8738. No tweaking, no special
>    parameters, no quirks.
>    With nforce2 sound, I needed a different tweak for each
>    of them (if one was available at all) and some were causing
>    strange effects. See the previous mails in this thread.
> 
> So far my general remarks from a user perspective.
> 
>  From a technical perspective, the nforce2 provides the following 8 
> IEC958 controls:
> 
> % amixer controls | fgrep IEC958
> numid=50,iface=MIXER,name='IEC958 Input Monitor'
> numid=36,iface=MIXER,name='IEC958 Playback Con Mask'
> numid=37,iface=MIXER,name='IEC958 Playback Pro Mask'
> numid=40,iface=MIXER,name='IEC958 Playback AC97-SPSA'
> numid=38,iface=MIXER,name='IEC958 Playback Default'
> numid=39,iface=MIXER,name='IEC958 Playback Switch'
> numid=48,iface=MIXER,name='IEC958 Capture Switch'
> numid=49,iface=MIXER,name='Analog to IEC958 Output'
> 
> While the CMI8738 provides the following 11 IEC958 controls:
> % amixer controls | fgrep IEC958
> numid=30,iface=MIXER,name='IEC958 5V'
> numid=29,iface=MIXER,name='IEC958 Copyright'
> numid=32,iface=MIXER,name='IEC958 In Monitor'
> numid=37,iface=MIXER,name='IEC958 In Phase Inverse'
> numid=38,iface=MIXER,name='IEC958 In Select'
> numid=28,iface=MIXER,name='IEC958 In Valid'
> numid=31,iface=MIXER,name='IEC958 Loop'
> numid=36,iface=MIXER,name='IEC958 Mix Analog'
> numid=34,iface=MIXER,name='IEC958 Playback Con Mask',device=2
> numid=27,iface=MIXER,name='IEC958 Output Switch'
> numid=33,iface=PCM,name='IEC958 Playback Default',device=2
> 
> note in particular that the IEC958 Loop is missing on the nforce2.
> Also, on the CMI8738, SPDIF out is available through hw:0,0 (the default
> for most programs), while the nforce2 only gave me access to the
> SPDIF out via hw:0,1 - and that was only 48kHz (a hardware attribute of the
> chip), so I had to use plughw:0,1 which caused other problems.
> 
> So, for now my problem is solved by installing an additional sound card -
> unfortunately at the expense of a precious PCI slot. :-(
> 
> Any work on Alsa that will make the nforce2 driver as good as the cmipci
> driver will be highly appreciated.
> 
> Cheers,
> 
> Carsten.
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-- 
    ___________________________________________________________
   (                                                           )
   | Carsten Koch                  Phone: +49-4286-920001      |
   | ICEM Technologies GmbH          Fax: +49-4286-1608        |
   | Sotheler Mühlenweg 15        mailto:Carsten.Koch@icem.com |
   | 27404 Elsdorf-Hatzte, Germany  http://www.icem.com        |
   (___________________________________________________________)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
