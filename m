From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Sound trouble with MCP61 chipset.
Date: Fri, 21 Sep 2007 19:38:11 -0700
Message-ID: <1190428691.9924.20.camel@razman.gruemaster.com>
References: <20070918180221.GI29734@miranda.org>
	<s5hy7f1pfzn.wl%tiwai@suse.de> <20070921164151.GE30453@miranda.org>
	<s5hbqbwotmy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 54F1F246DD
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Sep 2007 04:38:15 +0200 (CEST)
In-Reply-To: <s5hbqbwotmy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steven Young <sdyoung@miranda.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-09-21 at 18:44 +0200, Takashi Iwai wrote:

> At Fri, 21 Sep 2007 12:41:51 -0400,
> Steven Young wrote:
> > 
> > On Thu, Sep 20, 2007 at 04:29:32PM +0200, Takashi Iwai wrote:
> > > Still too little information to analyze.  I see only that you
> > > apparently have an ASUS machine with HD-audio controller.
> > > Which version of ALSA driver are you using?  Which codec is on it?  It
> > > can be obtained from /proc/asound/card0/codec#* file.
> > 
> >   I am using the codec "Analog Devices AD1986A", with ALSA 1.0.14rc1 
> > (which is the default with Ubuntu), and the snd_hda_intel kernel module.
> 
> It's way too old :)  Try 1.0.15rc2, first.
> 

If you still have problems after installing 1.0.15rc2, please run 
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh and send me
the resulting link.  It's probably too late to make 1.0.15, but I should
be able to get you a patch that will make the next release.

-- 
Tobin Davis  


In Pocataligo, Georgia, it is a violation for a woman over 200 pounds
and attired in shorts to pilot or ride in an airplane.
