From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Why does Alsa sometimes not find the HDSP 9652?
Date: Sun, 21 Dec 2003 09:14:05 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072026845.4077.2.camel@Wizard.knechthome.com>
References: <1071937305.5565.1.camel@Wizard.knechthome.com>
	 <1072020074.8692.20.camel@lotte.street-vision.com>
	 <1072022581.2814.12.camel@Wizard.knechthome.com>
	 <1072026666.8692.29.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1072026666.8692.29.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Justin,
   I'm running Alsa-1.0.0rc2. How much more up to date could I be?

   Also, this is an HDSP 9652 which has the firmware on the board. Why
is a firmware loader required at all?

   Possibly you're on to something I don't see yet? Maybe something is
left over from an older version and causing problems?

Let me know,
Mark

On Sun, 2003-12-21 at 09:11, Justin Cormack wrote:
> On Sun, 2003-12-21 at 16:03, Mark Knecht wrote:
> > Justin,
> >    Hi. Thanks. syslog from that series of boots is attached.
> > 
> > Note the first boot, line 304 looks like this:
> > 
> > Dec 20 05:43:46 Wizard kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:807: wait for FIFO status <= 0
> > failed after 100 iterations
> > Dec 20 05:43:46 Wizard kernel: RME Hammerfall-DSP: no cards found
> 
> ah. Update your alsa to the latest version. This is the old firmware
> loader bug. It is fixed now (but there is a seperate loader hdsploader
> that you have to run).
> 
> Justin
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
