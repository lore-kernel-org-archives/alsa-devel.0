From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Re: Too much latency with default:0,
	problem with period_time on dmix-dsnoop
Date: Tue, 21 Nov 2006 10:22:04 -0500
Message-ID: <7c5010d60611210722t4361625bh2c79fd2c0d97dae@mail.gmail.com>
References: <7c5010d60611200900n40c805d4p8abab809482152d6@mail.gmail.com>
	<s5hd57ikp36.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd57ikp36.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Trying to check if I understood.

To change the period_time of the myapp:n pcm used by my application,
instead of using default:n, I have to:

1) write somewhere a file that contains the overriding definitions
(pcm.myapp0, pcm.myapp1, etc) similar to the one below
2) create a pointer to that file with snd_input_stdio_open
3) use snd_config_load_override to load the content of that file into
the global snd_config structure, overriding the preexisting values

Is this correct?

If my app do this, it will affect other apps that happens to use one
of the default:n pcms or will be only my app that get the modified pcm
behavior (a different period_time)?

there is a more practical way to obtain a device:0...device:n with
dmix-dsnoop and a specified period_time?

Thank you in advance,
Giovanni

My sample /somewhere/myapp_asound.conf:

============
pcm.dmixed0 {
       ipc_key 1025
       type dmix
       slave {
               pcm "hw:0"
               period_time 20000
       }

}

pcm.dsnooped0 {
       ipc_key 1027
       type dsnoop
       slave {
               pcm "hw:0"
               period_time 20000
       }
}

pcm.asymed0 {
       type asym
       playback.pcm "dmixed0"
       capture.pcm "dsnooped0"
}

pcm.myapp0 {
       type plug
       slave.pcm "asymed0"
}


pcm.dmixed1 {
       ipc_key 1035
       type dmix
       slave {
               pcm "hw:1"
               period_time 20000
       }

}

pcm.dsnooped1 {
       ipc_key 1037
       type dsnoop
       slave {
               pcm "hw:1"
               period_time 20000
       }
}

pcm.asymed1 {
       type asym
       playback.pcm "dmixed1"
       capture.pcm "dsnooped1"
}

pcm.myapp1 {
       type plug
       slave.pcm "asymed1"
}


etc. etc. for myapp2...myappn

============

On 11/20/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 20 Nov 2006 18:00:11 +0100,
> Giovanni Maruzzelli wrote:
> >
> > Hi Takashi, hi all,
> >
> > I have a problem of too much latency using from C the "default:n"
> > devices under ALSA (if I understood correctly, this is because the
> > "default:n" devices uses dmix and dsnoop, and I need dmix and dsnoop,
> > but dmix and dsnoop have a fixed period_time=125000).
> >
> > I was able to solve this problem with an asound.conf, specifying the
> > period_time in both the dmix and dsnoop that constitute the asym that
> > I made the default.
>
> The default pcm period_size (or period_time) can be defined globally
> per card-type such as
>
> cards.EMU10k1.pcm.dmix.period_size   512
>
> or
>
> cards.ICE1712.pcm.dmix.period_time   20000
>
> (I'm not sure whether it's available for 1.0.13 but at least HG
>  version supports this.)
>
> > There is a way to do the same from the command line, in a way similar to:
> > aplay -D"plug:'dmix:RATE=44100'"
>
> Similarly, the default rate can be defined as
>
> defaults.pcm.dmix.rate  44100
>
> (Optional) arguments can be defined together with the PCM definition,
> too.  For example, to add RATE option to your dmixed PCM, define like
> below:
>
> pcm.dmixed {
>         @args [ RATE ]
>         @args.RATE {
>                 type integer
>                 default 48000
>         }
>         type dmix
>         ipc_key 1025
>         slave {
>                 pcm "hw:0"
>                 period_time 20000
>                 rate $RATE
>         }
> }
>
>
> > Also (and maybe better), there is a way to "build" a device similar to
> > the one builded by this asound.conf from the C api?
>
> A silly but workable solution would be to create a text file
> containing the new config and read it via snd_config_load() or such.
>
>
> Takashi
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
