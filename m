From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice1712 IPGA and ADC controls
Date: Mon, 29 Jan 2007 09:09:05 +0000
Message-ID: <200701290909.05343.gineera@aspect135.co.uk>
References: <loom.20070120T001557-202@post.gmane.org>
	<20070127123807.GA2662@localhost.localdomain>
	<loom.20070128T211007-41@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <loom.20070128T211007-41@post.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tim <terminator356@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sunday 28 January 2007 20:54, Tim wrote:
> Tim wrote:
> > > > What happened to all the input gain controls (IPGA) in the ice1712
>
> driver?
>
> Alan wrote:
> > >     - ak4xxx - Remove bogus IPGA controls
>
> I just looked at the AK4524 datasheet.
> Well, the gain and attenuation are certainly two seperate
>  parts of the chip combined into one register. But ultimately
>  are two means to an end.
> Table 12, the IPGA Code Table says it all, for me.
> See that gain (db) column?
> THAT is what I want to see when I look at a slider! How 'bout you?

I want to see controls that reflect the actual hardware, where it will 
influence the performance.  If the user does not understand the concepts of 
dynamic range, signal-to-noise ratio, clipping, headroom, harmonic distortion 
and others, then they are unlikely to get good results out of the rest of 
their studio equipment.  Knowing about those issues underlines why pre-ADC 
gain is vastly different from post-ADC digital attenuation, and the two 
should not be mixed up just because they both vary the gain from the socket 
to the pcm stream.

> To merge a point made previously: If users of these cards are
>  more "technical" or "professional", then they will understand
>  what they are doing, either because they know, or we simply tell
>  them with a helpful line about this matter in the readme.
> Right?
> BTW if any mixer out there is to do this correctly it could only
>  be envy24control. I don't know if any standard alsa mixer could
>  know about the specific db steps on these chips.
>
> My spider senses tell me the envy24control devels are working on this.
> Right guys?... Hello?...
>
> Tim.

Also, lets not confuse the controls the alsa driver provides with how a GUI 
mixer such as envy24control presents those to a user.  It seems (Takashi 
please confirm) that this change is removing the separate controls from the 
AK4524 driver code, meaning that no alsa-driver using AK4524 can provide them 
separately.  With a single control the driver has no way to dictate labelling 
of '0dB' level (or any other useful notes) when used in a mixer.

It is another issue whether, with 2 controls in the driver, the GUI should 
combine them to a single GUI slider.  In this case I would still augue 
strongly for two controls, due to the importance of the distinction in the 
electronic circuit functions on the signal performance.


Alan


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
