From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Mitac 8252D hda_intel
Date: Thu, 15 Nov 2007 08:53:33 -0800
Message-ID: <1195145613.5200.55.camel@razman.gruemaster.com>
References: <200711132051.10170.glvals@internet.is>
	<s5hfxz7d9dh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id BEAF82462C
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 17:53:36 +0100 (CET)
In-Reply-To: <s5hfxz7d9dh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: glv <glvals@internet.is>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-11-15 at 12:40 +0100, Takashi Iwai wrote:

> At Tue, 13 Nov 2007 20:51:10 +0000,
> glv wrote:
> > 
> > (Second attempt, hope this works)
> > 
> > Hello,
> > I have a Mitac 8252D computer with hda_intel, it has 3 sockets in front: 
> > microphone, audio(headphones)and S/PDIF. 
> > When using 5.1 the manual says:
> > Microphone: rear speakers
> > Audio:  front speakers
> > S/PDIF: center and subwoofer  
> > Modprobing without any options gives me sound to the headphone and digital 
> > socket and 
> > Modprobing with model=6stack-hp gives me sound to the speakers to but they 
> > stay on when headph. are pluged in
> > 
> > Output from alsa-info.sh:
> > http://pastebin.ca/772406
> 
> Posting here, at least the content of /proc/asound/codec#*, would be
> more helpful.

The link he posted is from alsa-info.sh, a script written by wishie on
 #alsa irc and heavily promoted by me.  It has the codec output, as
 well as everything else needed to determine how his system is
 configured.

> Is the SPDIF optical?  If yes, the device should have two output pins,
> one for SPDIF and one for CLFE.  That'll be relatively easy.
> If the SPDIF output is really shared, it means that the digital audio
> out widget is used for the analog out, too.  It's not implemented in
> other devices, so the change would be somehow unique for this device.

Actually, a lot of laptops (mine included) have a mini-TOS plug    
 combined with a headphone plug, so it is possible for an optical jack
 and an analog jack to share space.  Plugging in an spdif cable with  
 mini-tos adapter activates the hp-detect routine.  I haven't tested
  spdif output yet (need a good stereo receiver), but that's the
 principle behind it.


-- 
Tobin Davis  


In case of atomic attack, the federal ruling against prayer in schools
will be temporarily canceled.
