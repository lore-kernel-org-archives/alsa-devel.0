From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: what does alsaconf do?
Date: Tue, 31 Jan 2006 17:12:18 +0000
Message-ID: <1138727538.9026.6.camel@localhost.localdomain>
References: <1138456724.9726.13.camel@localhost.localdomain>
	 <20060129114023.GA16314@palantir8>
	 <1138539085.9221.2.camel@localhost.localdomain>
	 <s5hr76oa3le.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 94315179
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 18:12:21 +0100 (MET)
In-Reply-To: <s5hr76oa3le.wl%tiwai@suse.de>
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
Cc: Martin Habets <errandir_news@mph.eclipse.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-01-31 at 15:12 +0100, Takashi Iwai wrote:
> At Sun, 29 Jan 2006 12:51:25 +0000,
> Adrian McMenamin wrote:
> > 
> > On Sun, 2006-01-29 at 11:40 +0000, Martin Habets wrote:
> > > On Sat, Jan 28, 2006 at 01:58:44PM +0000, Adrian McMenamin wrote:
> > 
> > > 
> > > If your hardware does not vary an alternative is to avoid alsaconf and
> > > hardcode the entries in /etc/modules.conf (or whatever you use).
> > > It would be quite substantial to rewrite alsaconf for your setup.
> > > If you really need such a tool maybe it would be better to write a
> > > ucalsaconf. Hard to say really, as I have no clue about the actual
> > > hardware you have.

> 
> I think you're confused between alsa.conf file and alsaconf script.
> They have nothing to do with each other.
> 
> alsa.conf is usually located at /usr/share/alsa (depending on
> configure option of alsa-lib), which defines the root configuration.
> For example, the "default" PCM or whatever is defined there.  (More
> precisely, it's defined in another file included from this root file.)
> 
> As Martin pointed, alsaconf sets up the _module_ configuration.  This
> is irrelevant from the library configuration files.
> 

Fair enough. But where do I get my alsa.conf from then? :)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
