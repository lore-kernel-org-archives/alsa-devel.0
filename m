From: Gabriel Ebner <ge@gabrielebner.at>
Subject: Re: ice1724 controls meaning
Date: Thu, 19 Feb 2004 02:03:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077141802.30615.9.camel@localhost>
References: <200402162232.38240@goldspace.net>
	 <s5h7jylybzz.wl@alsa2.suse.de>  <200402181539.13804@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402181539.13804@goldspace.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Am Mit, den 18.02.2004 schrieb Andrew Gaydenko um 13:39:
> - for "CD In 1" card input both the control values must be 'CD Left',
> - for "Line In" input both control values must be 'Aux Left' (or 'Aux Right'? - don't 
>   remember now, but it isn't important).

> You see, both control must have the _same values_ for normal _stereo_ capturing.
Yeah, I've got that too.

> - my brain,
Then it's mine too. :)

> > > numid=5, iface=MIXER,name='H/W Playback Route'
> > numid=6, iface=MIXER,name='H/W Playback Route',index=1
> > ...
> > numid=12,iface=MIXER,name='H/W Playback Route',index=7
> 
> the analog output routing for each channel.  they're enum.
BTW, is there any way to get both CD and line mixed together at the same
time or are they exlusive?

	Gabriel.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
