From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Error: firmware not found
Date: 24 Jan 2005 13:55:11 -0800
Message-ID: <1106603711.2151.20.camel@cmn37.stanford.edu>
References: <20050122113702.023929f1.pochini@shiny.it>
	 <1106447855.2368.29.camel@cmn37.stanford.edu>
	 <s5hbrbf2lb3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrbf2lb3.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-01-24 at 02:06, Takashi Iwai wrote:
> At 22 Jan 2005 18:37:36 -0800,
> Fernando Lopez-Lezcano wrote:
> > 
> > On Sat, 2005-01-22 at 02:37, Giuliano Pochini wrote:
> > > Since my echoaudio driver is the first driver which is using the new
> > > "standard" firmware loader, I can anticipate what you have to expect when
> > > other drivers will be converted to that interface: people will not be able
> > > to make them work.
> > > 
> > > I don't know what distributions are doing, but it is causing users (and, in
> > > turn, to me) a lot of trouble. I located these main problems in the latest
> > > hotplug scripts (hotplug-2004_09_23):
> > > 
> > > - /etc/hotplug/firmware.agent sets FIRMWARE_DIR=/lib/firmware, but
> > > alsa-firmware install the files in /usr/lib/hotplug/firmware .
> > 
> > Yes, I noticed this and I'm packaging for fc3 / Planet CCRMA (which uses
> > /lib/firmware) by setting that directory explicitly in the alsa-firmware
> > configure step. I have at least two users that have successfully used
> > echoaudio cards. 
> 
> IMO, it's a bug of hotplug if it doesn't look at the old path,
> /usr/lib/hotplug/firmware.  Of course, passing the proper path to
> configure script would be the best solution, though.

Hmmm, it did not occur to me to try :-) I just played it safe and passed
the proper path to the configure script...

-- Fernando




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
