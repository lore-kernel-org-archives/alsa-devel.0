From: Ville Herva <vherva@vianova.fi>
Subject: Re: Re: ice1724 M-Audio Revolution 5.1 support?
Date: Wed, 28 Dec 2005 21:14:58 +0200
Message-ID: <20051228191458.GI21365@vianova.fi>
References: <20051017192155.GA16945@v.iki.fi> <20051018093139.GA19128@v.iki.fi> <s5hr7ajkvwj.wl%tiwai@suse.de> <20051019184936.GB24719@vianova.fi> <s5hmzl4jx34.wl%tiwai@suse.de>
Reply-To: vherva@vianova.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzl4jx34.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2005 at 12:34:39PM +0200, you [Takashi Iwai] wrote:
> At Wed, 19 Oct 2005 21:49:36 +0300,
> Ville Herva wrote:
> > 
> > On Tue, Oct 18, 2005 at 11:38:04AM +0200, you [Takashi Iwai] wrote:
> > > At Tue, 18 Oct 2005 12:31:39 +0300,
> > > Ville Herva wrote:
> > > > 
> > > > On Mon, Oct 17, 2005 at 10:21:56PM +0300, you [Ville Herva] wrote:
> > > > > Hi,
> > > > >  
> > > > > is support for M-Audio Revolution 5.1 planned? It appears quite similar to
> > > > > 7.1. I tried the monkey-see-monkey-do approach, and simply added the device
> > > > > ID to the driver (see the attached patch against 2.6.14-rc4), but that
> > > > > doesn't quite work - I get
> > > > >  
> > > > >    alsa_setup(): Sample format not available for playback: Invalid argument
> > > > >  
> > > > > thanks...
> > > > 
> > > > Well, duh, I forgot to attach the patch.
> > > 
> > > BTW, I suspect 5.1 has the same codec chips as 7.1.
> > > 
> > > Revo 7.1 has AK4381 and AK4355, the former is for front output and the
> > > latter is for the rest 6 channels.  On Revo 5.1, it might be a single
> > > chip supporting all 6 channels.  So, you should check it at first.
> > > Just take a look at your board precisely.
> > 
> > It appears the 5.1 has a different DAC:
> > 
> > Controller IC
> > Revo 7.1 - VIA Envy24HT - 24-bit/196 kHz I/O for analog and digital
> > Revo 5.1 - VIA Envy24GT - 24-bit/192 kHz for digital, 24-bit/96 kHz for analog
> 
> Oh, another model?  Sigh...
> 
> 
> > DAC
> > Revo 7.1 - AKM AK4381, AK4355 (108/106 dB signal-to-noise ratio, 24-bit/192 kHz playback)
> > Revo 5.1 - AKM AK4358 (112 dB signal-to-noise ratio, 24-bit/96 kHz playback)
> > 
> > ADC
> > Revo 7.1 - AKM AK5380 (100 dB signal-to-noise ratio, 24-bit/96 kHz recording)
> > Revo 5.1 - AKM AK5365 (103 dB signal-to-noise ratio, 24-bit/96 kHz recording, fixed to 48 kHz)
> > 
> > Still with the stupid patch I posted, I do get some (distorted) sound. 
> > 
> > I wonder if it would be hard to properly support AK4358...?
> 
> AK4358 is already supported (Juli uses it).
> If the communication protocol is as same as revo 7.1, it wouldn't be
> too difficlt to implement.  But chechking the communication protocol
> _is_ the most important thing.
> 
> You can do a trial-and-error, or check the pin connection between
> ICE1724 and the codec chip.

I noticed you had added support for Revolution 5.1 in alsa-1.0.11rc1.
Basically, it seems to work great. Thanks!

I have one problem still. When I try to configure sw mixer for revo51, the
sound badly stutters no matter what asounrc variation I try. The secondary
sound device (i815 audio) does not have this problem: sw mixer sound is
perfect.

Any idea what might be wrong?

revo51
--8<-----------------------------------------------------------------------
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

pcm.swmix {                       
        type dmix
        ipc_key 1235                                                  
        slave        
        {                                   
                pcm ice1724          
                format S32_LE
                period_time 0                       
                period_size 1024
                buffer_size 32000
        }                                          
}                                              
--8<-----------------------------------------------------------------------

i815
--8<-----------------------------------------------------------------------
pcm.swmix2 {
        type dmix
        ipc_key 1234
        slave {
                pcm "hw:1,0"
                period_time 0
                period_size 1024
                buffer_size 32000
                rate 44100                                
        }
}           
--8<-----------------------------------------------------------------------




-- v -- 

v@iki.fi



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
