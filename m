From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: ice1712 IPGA and ADC controls
Date: Mon, 29 Jan 2007 19:15:51 +0000
Message-ID: <20070129191551.GA2673@localhost.localdomain>
References: <loom.20070120T001557-202@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7iv61116.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 29, 2007 at 01:16:05PM +0100, Takashi Iwai wrote:
> At Sun, 28 Jan 2007 22:59:52 +0000,
> Well, the ice1712 hardware is somehow strange.  On this chip, both the
> analog attenuation and the IPGA are connected with each other, and can
> _not_ be controlled separately.  That is, when you set analog
> attenuation to non-zero, you cannot set IPGA at all.  Similarly, if
> you set IPGA non-zero, analaog attenuation must be zero.  Hence,
> recent implementation is the straightforward implementation from the
> hardware perspective.

If a single volume bar is implemented, does it leave the analog
attenuation at zero and adjust the digital attenuation, or does
it leave the digital attenuation at zero and adjust the analog
attenuation? If I had to choose one or the other it would usually
be the latter. Digital and analog attenuation are not the same in
terms of quality, especially when the digital attenuation acts on
integer samples as opposed to floating point.

I can see the argument for making it simple for the non-technical
user, but the quality level required by the pro/semi-pro user must
still be attainable. Personally I'd rather see both sets of controls
in the driver, even if only one volume bar appears in the mixer app.
At least then there's still the option of controlling one or the other
(even if it means patching envy24control ;-)).

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
