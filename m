From: pshirkey@boosthardware.com
Subject: Re: Re: Experimental USB audio support
Date: 4 Jun 2002 04:12:39 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020604041239.20997.qmail@www7.networkshosting.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 6/3/2002 - 21:59:15, Takashi Iwai  said:
> At Mon, 03 Jun 2002 14:52:57 +0900,
> Patrick Shirkey wrote:
> > 
> > Takashi Iwai wrote:
> > > 
> > > At Fri, 31 May 2002 20:55:01 +0900,
> > > Patrick Shirkey wrote:
> > > >
> > > > Takashi Iwai wrote:
> > > > >
> > > > > now a new version is cvs.  it dumps the 
descriptor at
> > > > > /proc/asound/cardX/descriptor.  if the cvs 
servers is not sync'ed,
> > > > > please let me know.  i'll send you a patch.
> > > > >
> > > >
> > > > With this patch there is *alot * more info in 
lsusb. Excellent work.
> > > 
> > > as you already know, it's not me but the update of 
usb modules :)
> > > 
> > > anyway, could you check again whether the driver 
works?
> > > just taking a look at the lsusb output, the device 
has no mixer units.
> > > there are only input/output terminals.
> > > so, don't be bothered even if you see no mixer 
controls.
> > > 
> > > Takashi
> > 
> > So far I cannot get sound out using
> > 
> >  cat /bin/bash > dev/dsp2
> >  aplay -D hw:2,0 -f cd some.wav
> > 
> > both return with device does not exist or similar
>  
> please apply the attached patch and build the modules with
> --with-debug=detect option.  if a pcm is to be created, 
then it shouls
> something.  or it will show an error message and the 
reason.
> 
> sorry, i have no time today - will take a deeper look at 
tomorrow.
> 

Me too :)


> 
> btw, creation of pcm devices is independent from mixer 
devices.
> so, i'm wondering why, too...
> 
> the descriptor info is necessary to build and look up 
pcms and
> controls for alsa.  basically the usb descriptor includes 
_all_
> necessary information to get the driver work.
> 

I guessed that. So in the interest of fully documenting 
ALSA driver design are you or others who grok it willing to 
write some notes on how to use/read that info?


--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
