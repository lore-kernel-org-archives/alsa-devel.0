From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Re: WM9712 Not Giving output
Date: Wed, 6 Aug 2008 03:04:07 -0700 (PDT)
Message-ID: <584334.24810.qm@web50106.mail.re2.yahoo.com>
References: <20080806092559.GA26169@sirena.org.uk>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50106.mail.re2.yahoo.com (web50106.mail.re2.yahoo.com
	[206.190.38.34]) by alsa0.perex.cz (Postfix) with SMTP id A4AA924788
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 12:04:08 +0200 (CEST)
In-Reply-To: <20080806092559.GA26169@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI!

--- On Wed, 6/8/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] WM9712 Not Giving output
> To: "Nitin Mahajan" <nitinm76@yahoo.com>
> Cc: alsa-devel@alsa-project.org
> Date: Wednesday, 6 August, 2008, 2:56 PM
> On Tue, Aug 05, 2008 at 08:06:06PM -0700, Nitin Mahajan
> wrote:
> 
> > Here is the mixer-config file got through
> 'alsactl'. Could you please guide me which controls
> to set with what values using amixer, for playback through
> Headphone and Recording?
> 
> For playback try these:
> 
> > 	control.4 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		comment.count 1
> > 		iface MIXER
> > 		name 'Headphone Playback Switch'
> > 		value false
> > 	}
> 
> This should be enabled.
> 
> > 	control.8 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		comment.count 1
> > 		iface MIXER
> > 		name 'Headphone Playback ZC Switch'
> > 		value false
> > 	}
> 
> It's better to enable this but not essential - it
> avoids audio artifacts
> while doing volume updates during playback.
> 
> > 	control.64 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		comment.count 1
> > 		iface MIXER
> > 		name 'Right Mixer PCM Playback Switch'
> > 		value false
> > 	}
> > 	control.65 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		comment.count 1
> > 		iface MIXER
> > 		name 'Left Mixer PCM Playback Switch'
> > 		value false
> > 	}
> 
> These should be enabled.
> 
> If this still gives you trouble then please build with
> DAPM_DEBUG
> enabled in soc-dapm.c (or #define DEBUG at very the top of
> the file
> prior to the includes if using a very current version). 
> This will cause
> ASoC to produce debug output when it starts playback which
> should show
> anything that needs to be enabled but isn't.
> 
> Please also make sure that you are using a driver with the
> patch that
> Marek identified earlier in the thread.

Thanks I will try setting these for playback. Just for the Hardware verification I tried setting registers myself for the Mixer. I understand that finally thats not the right way. AS u suggested in earlier the gain was problem. I was making it as negative gain, which is as good as mute.
I kept it default and playback worked for me.

I am not able to make the Mic recording work now. Apart from the mixer controls, I identified these registers to be programmed with following values, which again to seperate out the problem area, H/w or S/w.I am using single ended mono microphone on Left i.e Mic 1.

Ox24h 0x0000
0x26h 0x0000
0x0Eh 0x6000
0x5Ch 0x0000
0x0Ah 0x7000
0x1Ch 0x0f00
0x20h 0x0000

Also , If I take the Linux-2.6.26 kernel from mips, can you tell me how to get the patch from wolfson ASOC git so that I have all the latest ASOC and WM related code?
I am not familiar with git :(.

Thanks in advance 

regards

-Nitin

 


      Get your new Email address!
Grab the Email name you&#39;ve always wanted before someone else does!
http://mail.promotions.yahoo.com/newdomains/aa/
