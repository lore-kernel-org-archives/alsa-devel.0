From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Hi ALSA Team - serious technical question from Ron
Date: Mon, 12 Jun 2006 11:52:53 +0100
Message-ID: <1150109573.21190.13.camel@localhost.localdomain>
References: <4c84399f0606042324o10e15f92t3320621c2f9064f9@mail.gmail.com>
	<4489CAAD.4010900@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4489CAAD.4010900@boosthardware.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Patrick Shirkey <pshirkey@boosthardware.com>, Ronald Stewart <ronaldjstewart@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-06-10 at 02:23 +0700, Patrick Shirkey wrote:
> 
> Ronald Stewart wrote:

> > Hey guys,
> > 
> > Can someone point me to the correct email address to ask this question?
> > 
> > I built a portable linux based multitrack studio/field recorder but we 
> > have yet
> > to get 24 bit audio sampling achieved on our prototypes.  Now we use a Soc
> > utilizing the Intel PXA270 and we have disabled the ac97 codec on board and
> > we are connecting the PXA to an AKM 4620A codec.  However, I was wondering
> > how much development has occured for this if at all.
> > Anyway I have many questions.  I decided over a year ago when I began that
> > we would always be a Linux based product, for all the right reasons and now
> > I could really use some help finishing this for producing the retail 
> > versions.
> > 

You may be interested in an embedded ALSA project I'm working on:-

http://www.rpsys.net/openzaurus/patches/alsa/info.html

We currently have support for the SSP, I2S and AC97 interfaces on the
PXA2xx SoC. You will need to use the SSP interface for 24bit audio, as
the AC97 and I2S interfaces only support 16bit samples on the PXA27x.

We don't have your codec (AKM4620A) supported atm, but it's quite
trivial to add new codecs (there are lots of examples). With a few other
minor changes to the ssp driver (adding 24 bit support) you should be
able to start playing/capturing some audio.

Liam
