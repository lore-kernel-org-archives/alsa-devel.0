From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: [Alsa-user] CS4205 (snd-intel8x0) missing recording inputs
Date: Mon, 18 Nov 2002 09:53:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000f01c28f12$45919fb0$ab1f830a@ICO>
References: <Pine.LNX.4.33.0211180948540.738-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211180948540.738-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you for your reply!

>Could you send me output from 'amixer contents' ?

Will do as soon as I get a hold of the laptop (later this afternoon).

>Are you kidding? It's a simple AC'97 codec. Please, check the
manufacture 
>information before flames (www.crystal.com).

>From what I saw on the website (again, this may be pure propaganda, but
it does seem like this thing does have some additional features, and
perhaps more importantly is capable of at least 2 hw streams, like Ess
Maestro 3i was/is -- however, let me state that I am not a hw/driver
specialist, so I may be misinterpreting this):

(http://www.crystal.com/design/products/overview/detail.cfm?d=146)

...
"Delta Sigma and mixed-signal technology"
...
"Coupling the CS4205 with a PCI audio accelerator or core logic
supporting the AC '97 interface"
...
"Digital docking of I2S output, 3 synchronous I2S inputs"
...
"Performance digital mixer with SRSR 3D stereo enhancement"
...
"S/PDIF digital audio output"
...

Also, what caught my eye is the "hw-mixer" which perhaps could be used
for down-mixing streams (I may be talking nonsense here).

I am not sure what this means, but judging from the given info, it does
not look to me like the basic on-board chip. I do remember using Ess
maestro 3i laptop chip, which was capable of providing 2 streams. The
other thing is that OSS (commercial) drivers do allow opening of the
second stream (which unfortunately does not work properly, go figure).

Finally, I did notice that if the laptop (Dell Inspiron 8200) does go
into the power-save mode (any of the aspects, such as powering down the
screen or anything else defined in the BIOS), that machine sometimes
hard-locks when trying to run sound stuff afterwards (0.9 rc5) using Mdk
9.0 (2.4.19 kernel), but I am not sure whether this has anything to do
with Alsa, I'll keep digging and see what I come up with.

Again, any help on this issue is greatly appreciated!

Ico



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
