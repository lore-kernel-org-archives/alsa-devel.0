From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: ice1712 IPGA and ADC controls
Date: Wed, 31 Jan 2007 10:42:32 +0000
Message-ID: <20070131104232.GA2846@localhost.localdomain>
References: <loom.20070120T001557-202@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
	<20070129191551.GA2673@localhost.localdomain>
	<loom.20070130T064723-509@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <loom.20070130T064723-509@post.gmane.org>
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

On Tue, Jan 30, 2007 at 06:18:38AM +0000, Tim wrote:
> There is no such thing as analog attenuation on these chips.
> Only an analog gain stage from 0db to +18, followed by a digital 
>  attenuation stage from 0db down to infinity (mute).
> Both of these functions are accessed through the same register,
>  as a continous range from 0 to 164. The first 127 steps
>  'activate' the digital attenuator, with 127 being 0db, while the
>  last 37 steps 'activate' the analog gain.
> In other words, from 0-127 ONLY the digital attenuation stage is
>  activated. From 128 to 164, ONLY the analog gain stage is activated.
> It was intended to be one control.

That makes sense (thanks for the clarification). I think it's
important to clearly mark the 0dB point, and also to make 0dB
the default setting.

> Anyways, I say we add some type of 'decorations' to envy24control.
> Some type of markings. Two end-to-end 'braces' along the side spanning the 
>  length of sliders, one labeled "digital att." meaning that the range from 
>  0-127 is digital attenuation, and the other labeled "analog gain" meaning 
>  the range 127-164 is analog gain. It would be a great visual reminder of 
>  this underlying technical detail we have discussed here, so everyone  
>  should understand it.

Good idea.

> And of course all values in db's as well as integers.

dB would be nice.

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
