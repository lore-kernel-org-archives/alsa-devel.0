From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with Avermedia 771
Date: Mon, 25 Oct 2004 11:36:13 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410251049550.7768-100000@studcom.urz.uni-halle.de>
References: <s5hd5zcgtj3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hd5zcgtj3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gerd Knorr <kraxel@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Gerd Knorr wrote:
> > Takashi Iwai wrote:
> > > That's the reason why I suggested the second way in my earlier post:
> > >
> > > We prepare two pci_id tables, one for the whitelist and another for
> > > the default ids.  Only the former is exported.
> > >
> > > When the module option is given, the latter id is registered while
> > > usually the fomer is used.
> >
> > Yep, that should make the correct ID list visible to hotplug ...
>
> Ok, how about the attached patch?

Committed now.


Gerd Knorr wrote:
> Clemens Ladisch wrote:
> > A centralized card list looks more advantageous now ...
>
> Hmm, along these lines maybe?
>
> [...]
> const struct bt878_entry* bt878_db_lookup(struct pci_dev *pci);

Yes, this would be fine.


Clemens



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
