From: Brian Kaney <brian@vermonster.com>
Subject: Re: Re: ICE1712 broken with *2.4.21*, alsa-1.0.6a
Date: Tue, 31 Aug 2004 14:19:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093976363.14802.8.camel@brian.vermonster.com>
References: <1C2Aqd-1bVVHk0@cmpmail10.bbul.t-online.de>
	 <s5hsma3z4c4.wl@alsa2.suse.de>
Reply-To: brian@vermonster.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsma3z4c4.wl@alsa2.suse.de>
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

First off I'd like to apologize for posting on both the users and devel
list.


On Tue, 2004-08-31 at 11:59, Takashi Iwai wrote:
> At Tue, 31 Aug 2004 17:47:03 +0200,
> Dirk.Kalis@t-online.de wrote:
> > 
> > Brain wrote:
> > >I"m having the same issue Ross mentioned in a thread a few days ago.
> > > Here"s my env:
> > > 
> > >- RH WS 3 (Linux 2.4.21-4.EL) i686
> > > - Terratec EWS 88D -- ICE1712 [Envy24] (rev 02)
> > > 
> > > I installed the drivers (1.0.6a) with:
> > > ./configure --with-cards=ice1712 --with-sequencer=yes
> > --with-redhat=yes
> > > 
> > > Then the envy24control with standard ./configure
> > > 
> > > I launch envy24control and find the same thing Ross described:
> > > 
> > > [root@omaha01 root]# envy24control
> > > using    --- input_channels: 0
> > >         --- output_channels: 0
> > >         --- pcm_output_channels: 8
> > >         --- spdif in/out channels: 2
> > >
> > > No analog control tab.  When I play sound, the bars in the control
> > > panel move, but there is not analog output.
> > > 
> > > In the previous thread, Luke mentioned checking the nodes in /dev.
> > > Wondering if this could be explained a bit more, as I am new to this.
> > > Any other help would be much appreciated!
> > >
> > > Thanks in advance!
> > > Brian
> >  
> > Takashi, i think this is correct because EWS 88D has no analog
> > inputs/outputs.
> > The driver parameters for num_total_dacs and num_total_adcs are set to 0
> > in ews.c.
> 
> Ah yes, you're right.
> 
> EWS 88D has really no analog outputs, so no analog volumes in
> envy24control.  Quite logical ;)
> 

The EWS 88D does in fact have an analog output.

You can see it in this image (it's the topmost plug)
http://productsen.terratec.net/modules/My_eGallery/gallery/produkte/sound-audio/ews88d/EWS88%20D%20Platine.jpg

And in the feature set (15th bullet under "The Highlights"):
http://productsen.terratec.net/modules.php?op=modload&name=Sections&file=index&req=viewarticle&artid=8

"Analog stereo output (SystemSound out) with 18-bit converter and up to
48 kHz, (3.5 mm jack) for MME and DirectSound"





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
