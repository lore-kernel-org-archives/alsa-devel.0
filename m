From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Fri, 4 May 2012 15:28:45 +0200
Message-ID: <20120504132845.GA24245@lovely.krouter>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
	<20120427134638.GI18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 29D9F246DC
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 15:28:52 +0200 (CEST)
Received: by werh12 with SMTP id h12so1351319wer.38
	for <alsa-devel@alsa-project.org>; Fri, 04 May 2012 06:28:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120427134638.GI18260@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 27, 2012 at 02:46:39PM +0100, Mark Brown wrote:
> On Fri, Apr 27, 2012 at 10:00:02AM +0200, Christoph Fritz wrote:
> > On Thu, 2012-04-26 at 22:37 +0100, Mark Brown wrote:
> 
> > >   The write will be suppresed if the register contents don't
> > > change which looks like what you're seeing here - 
> 
> > Can you imagine why the registers don't change?
> 
> I can't immediately think of any reason, no - I'd step through or
> annotate the code and have a look.

I'm still on.

And while testing WM9712 its touchpad interface, connecting a 800x600
display (instead of the default 640x480 one) results in a gone sound and
input-device - pretty queer:

WM9711/WM9712 SoC Audio Codec 0.4
asoc: platform pcm constructor failed
asoc: can't create pcm HiFi
asoc: failed to instantiate card PhyCORE-ac97-audio: -12

I have to admit that I used this time a 3.2 kernel. I'll test with
current later these days.


Thanks,
 -- Christoph
