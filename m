From: Rusty Phillips <rustyp@freeshell.org>
Subject: Re: Crackling sounds with Omnistudio USB
Date: Fri, 21 Jan 2005 20:03:13 -0500
Message-ID: <1106355793.17958.39.camel@localhost.localdomain>
References: <1106345994.17958.31.camel@localhost.localdomain>
	 <1106347480.3232.67.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106347480.3232.67.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As to the version of Linux, I'm running 2.6.10 with the Alsa-CVS
drivers, and 2.4.26 with the Alsa-CVS drivers.

Unfortunately, I can't give you a link to the exact page for the USB
filter driver, but you can get to it from the VIA drivers page (just
select any Windows OS (I use 2000) and pick USB then USB 1.0 drivers)
http://www.viaarena.com/Default.aspx?PageID=2

Here's the description from the VIA page about the filter driver:

This patch fixes very specific issues under specific circumstances,
described below. Users who are unsure as to whether they should install
the patch can be assured that if they do install the patch, even if it
is not necessary, it will cause no harm to their system. The patch will
detect your systems configuration and install only when necessary. The
patch will only install on certain older VIA host controller revisions.
Under these circumstances, the patch will resolve the following issues: 

      * Fixes the issue when a connected usb hub that has no usb devices
        connected will be disabled after another usb hub is attached at
        another available root port. 
      * Fixes the issue when transferring large of amounts of data, the
        system will hang. 
      * Avoids noise from a USB audio converter or speaker. 
      * Supports a usb 1.0 add-on card. Note that this patch does not
        assist with problems concerning USB 2.0 add-on cards. 
      * Under Win2000/XP: This patch will save all register values in
        the memory before a system enters Stand By mode and then restore
        those registers when the systems resumes. This therefore avoids
        the situation where USB devices are not ready for use after a
        resume from Stand By mode. 

On Fri, 2005-01-21 at 17:44 -0500, Lee Revell wrote:
> On Fri, 2005-01-21 at 17:19 -0500, Rusty Phillips wrote:
> > I've done a lot to narrow this down, and I know I'm getting crackles and
> > pops on my Omnistudio USB from within the computer (it has zero latency
> > monitoring, so I can hear what happens on the device).
> > 
> > This only happens when recording - not playback, and I know it happens
> > on both my Intel 440BX motherboard (which doesn't have any problems
> > reported - not sure of the actual model) and my Abit KG7, which has a
> > Via 686B southbridge, which is reported to show such problems.
> > 
> > The Abit board is dual-boot, and I found a Windows USB patch from VIA
> > called the "USB filter patch."  This got rid of the pops and crackles
> > when recording in Windows.  
> 
> Please give some more information about what the USB filter patch does.
> Got a link?
> 
> What kernel are you using?
> 
> Lee
> 




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
