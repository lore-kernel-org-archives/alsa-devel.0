From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
Date: Thu, 26 May 2005 00:18:28 -0700
Message-ID: <20050526001828.0b3959f6.akpm@osdl.org>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1115594680l.7540l.0l@werewolf.able.es>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 05.08, J.A. Magallon wrote:
> > 
> > On 05.05, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > > 
> > > - device mapper updates
> > > 
> > > - more UML updates
> > > 
> > > - -mm seems unusually stable at present.
> > > 
> > 
> > Ehem, is ALSA broken ?
> > 
> > I can't spread stereo output to 4 channel. More specific, I can't switch
> > one of my female jacks between in and out.
> > 
> > Long explanation: I have an
> > 
> > 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> > 
> > It has three outputs. One is always output, for normal stereo or front in 4
> > channel. One other is LineIn/Back-for-4-channel. And the third is
> > Mic/Bass-Center.
> > 
> > In 2.6.11 I have two
> > toggles in ALSA: 'Spread front to center...' and 'surround jack as input'
> > Adjusting both I could get to duplicate the output in the Back jack.
> > In 2.6.12-rc3-mm3 there is no way to get this working.
> > 
> 
> I have just tested in 2.6.12-rc4 and works fine. I even feed the stereo
> signal to the 6 channels, so 4 go to my desktop speaker system and one
> other pair to may home stereo.
> 
> Something is broken in -mm wrt ALSA. If you need me to test some specific
> version, pleas just ask.
> 
> Side note: trying to load settings from rc4 in -mm says:
> 
> alsactl: set_control:930: warning: name mismatch (Surround Jack as Input/Surround Jack Mode) for control #42
> alsactl: set_control:932: warning: index mismatch (0/0) for control #42
> alsactl: set_control:1030: bad control.42.value type
> 

Could we have an update on this please?  Do these problems persist in
2.6.12-rc5 and/or 2.6.12-rc5-mm1?

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
