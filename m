From: Ville Herva <vherva@vianova.fi>
Subject: Re: ice1724 M-Audio Revolution 5.1 support?
Date: Tue, 18 Oct 2005 23:37:15 +0300
Message-ID: <20051018203715.GQ24719@vianova.fi>
References: <20051017192155.GA16945@v.iki.fi> <s5hu0ffkxgx.wl%tiwai@suse.de>
Reply-To: vherva@vianova.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu0ffkxgx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2005 at 11:04:14AM +0200, you [Takashi Iwai] wrote:
> At Mon, 17 Oct 2005 22:21:56 +0300,
> Ville Herva wrote:
> > 
> > Hi,
> >  
> > is support for M-Audio Revolution 5.1 planned? It appears quite similar to
> > 7.1. I tried the monkey-see-monkey-do approach, and simply added the device
> > ID to the driver (see the attached patch against 2.6.14-rc4), but that
> > doesn't quite work - I get
> >  
> >    alsa_setup(): Sample format not available for playback: Invalid argument
> 
> If you used "hw" PCM, the above is no fatal error.
> ICE1724 supports only 32bit format.  For playing 16bit or other
> formats, you have to convert it via plug layer.  For example,
> 
> 	% aplay -Dplughw foo.wav
> 
> But, the default configuration is already like above, so even just
> "aplay foo.wav" should work.

Well, I can get sound out of the device, but no matter what I try, I only
get seriously distorded sound. And the volume setting (I'm using headphone
output) doesn't work at all.

I'm trying 

aplay -Dpcm.dsp0 test.wav

and I have this in my .asoundrc:

pcm.mix {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"      # you cannot use a "plug" device here, darn.
        period_time 0
        period_size 512
        buffer_size 4096
        format S32_LE
    }
}
 
pcm.dsp0 {
    type plug
    slave.pcm "mix"
}

But I've tried a bunch of other setting none of which seemed to make
different. Among others I tried:

pcm.ice1724 {
           type hw
           card 0 
}
 
ctl.ice1724 {
    type hw  
    card 0   
}
 
pcm_slave.ice1724_S32_LE {
    pcm ice1724
    format S32_LE
}
 
pcm.ice1724_convert {
    type plug
    slave ice1724_S32_LE
}

and 

aplay -Dpcm.ice1724_convert test.wav


But at least I'm getting sound out of the device :)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
