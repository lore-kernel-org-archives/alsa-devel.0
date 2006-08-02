From: Cruise X Overide <cruiseoveride@gmail.com>
Subject: Re: GPIO on envy24ht M-Audio 192
Date: Wed, 02 Aug 2006 15:37:43 -0400
Message-ID: <1154547463.7149.9.camel@server>
References: <1154390773.1991.1.camel@server> <s5hd5bkbfrw.wl%tiwai@suse.de>
	<1154454336.3383.8.camel@server> <s5hvepbhzhx.wl%tiwai@suse.de>
	<1154536420.7149.2.camel@server> <s5hslkfhypo.wl%tiwai@suse.de>
	<1154539779.7149.7.camel@server>  <s5hk65rhwam.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk65rhwam.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-02 at 19:39 +0200, Takashi Iwai wrote:
> At Wed, 02 Aug 2006 13:29:39 -0400,
> Cruise X Overide wrote:
> > 
> > On Wed, 2006-08-02 at 18:46 +0200, Takashi Iwai wrote:
> > > At Wed, 02 Aug 2006 12:33:40 -0400,
> > > Cruise X Overide wrote:
> > > > 
> > > > On Wed, 2006-08-02 at 18:30 +0200, Takashi Iwai wrote:
> > > > > At Tue, 01 Aug 2006 13:45:36 -0400,
> > > > > Cruise X Overide wrote:
> > > > > > 
> > > > > > On Tue, 2006-08-01 at 18:08 +0200, Takashi Iwai wrote:
> > > > > > > At Mon, 31 Jul 2006 20:06:13 -0400,
> > > > > > > Cruise X Overide wrote:
> > > > > > > > 
> > > > > > > > Ok, i got the wiring between between the vt1724 and the 3 dacs (AKMs)
> > > > > > > > how do i code this into the driver, 
> > > > > > > > is there any example, i looked at juli.c and i couldnt understand the 
> > > > > > > > 
> > > > > > > > /* GPIO Pins */
> > > > > > > > 
> > > > > > > > i was told that i only need to implement add_controls and init for this
> > > > > > > > card?
> > > > > > > 
> > > > > > > There are different implementations with vt1724.
> > > > > > > revo.c, aureon.c, pontis.c, prodigy192.c and phase.c are vt1724-based
> > > > > > > boards using I2S transfer.  vt1720_mobo.c is for vt1724 with
> > > > > > > ac97-codec.
> > > > > > > 
> > > > > > > The GPIO is usually controlled via snd_ice1712_gpio_write_bits() and
> > > > > > > snd_ice1712_gpio_read().  See ice1712.h.
> > > > > > > 
> > > > > > > For AK codecs, there are some helper functions.  See
> > > > > > > snd_ak4xxx_private in ice1712.h, too.
> > > > > > > 
> > > > > > > 
> > > > > > > Takashi
> > > > > > 
> > > > > > after looking at the juli.c, raymond has explained to me the meaning of
> > > > > > the values under the /* GPIO Pins */
> > > > > > 
> > > > > > 
> > > > > > #define GPIO_ANAIN_MONITOR      (1<<13) 
> > > > > > 
> > > > > > i wanted to know wat the 13 means, and ray said it was the gpio pin.
> > > > > > where do i find a table of gpio description (eg. AMAIN_MONITOR) and
> > > > > > available definitions on the vt1724.
> > > > > 
> > > > > The GPIO pin assignment is the board specific implementation, so it's
> > > > > nowhere described in VT1724 database, of course.  (If you have a
> > > > > board, you can even trace the connection with loupe :)
> > > > > 
> > > > > 
> > > > > Takashi
> > > > 
> > > > im completely new to driver development.
> > > > how do i tell my (/linux/sound/pci/ice1712/ap192k.c) driver which gpio
> > > > pins connect to wat? i have all the wiring from ak4385 and ak4114 to the
> > > > envy24ht, as well as the data sheets, can someone point me in the
> > > > direction i have to take to get this driver working? and please for god
> > > > sake dont tell me to go and read, if u know the answer, dont be shy,
> > > 
> > > One of the following ways:
> > > 
> > > 1. Get a datasheet of your board (not vt1724) from the hardware
> > >    vendor.  There must be a diagram or a table of pin connection
> > >    there.
> > > 
> > > 2. Look close the board design and trace the pin connections between
> > >    vt1724 and codec chips.  The pin numbers are found in datasheet of
> > >    vt1724 and each codec chip.
> > > 
> > > 3. Trial-and-error the different pin numbers, assuming that the board
> > >    is almost compatible with other models.
> > > 
> > > But, before going there, you have to know what kind of data transfer
> > > is used - whether the normal i2c connection (via snd_vt1724_write_i2c)
> > > or over own transfer protocol with GPIO.  In the latter case, then
> > > you'd need to know which transfer mode, SPI or I2C, and whether
> > > CIF-mode is not, etc.
> > > 
> > > So, it's basically not how well you are skilled about driver
> > > programming but how well you know about the board implementation.
> > > 
> > > 
> > > Takashi
> > 
> > 1,2,3 done, 
> > we're using i2c.
> > 
> > 
> > i have 
> > envy24ht->ak4358
> > envy24ht->ak4114
> > 
> > all gpio stuff on the envy have been mapped onto the aks
> > 
> > now wat
> 
> Wat?
> 
> 
> Takashi

how do i figure out the i2c address of each codec chip
is this in the datasheet of the aks?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
