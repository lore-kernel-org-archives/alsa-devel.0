From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Sat, 9 Oct 2004 00:04:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041009000445.0ef85b2a.pochini@shiny.it>
References: <s5h6566zhlq.wl@alsa2.suse.de>
	<XFMail.20040923102231.pochini@shiny.it>
	<s5h7jqlxnnp.wl@alsa2.suse.de>
	<20041007220154.37b79947.pochini@shiny.it>
	<s5hmzyx5krr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzyx5krr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 08 Oct 2004 16:47:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > > In the case of au88x0, it was hard to merge because they use different
> > > addresses in each chip, while echo boards seem to have the same
> > > register offsets, right?
> > > But I don't insist on this rewrite if you prefer keeping this, of
> > > course.
> >
> > Most of the #ifdef's are used to exclude unused controls. Those parts can be
> > moved into separate files and included from <card>.c just like the other
> > parts. snd_ctl_add() calls will remain inside conditionals anyway.
>
> Sounds better (unless this results in too many files :)

8 new files... And I'm not sure it looks better than before.

http://xoomer.virgilio.it/g_pochini/ea-0.9.0.tar.bz2


> About the firmware: since the recent 2.4 kernel also includes
> request_firmware(), it's the easiest way to go, I believe.
>
> I'll rewrite the firmware code later for other drivers.  I'll likely
> keep the old implementation of ALSA firmware loader for the cases that
> no kernel fw-loader is configured or the driver is built in kernel.
>
> If you finish them, please send me the patch.

I've not written the firmware loader yet. I'll do it during the week end.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
