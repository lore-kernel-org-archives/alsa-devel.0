From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-driver-1.0.6a unresolved symbol
Date: Mon, 11 Oct 2004 13:58:45 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410111356480.8356-100000@studcom.urz.uni-halle.de>
References: <200410100029.48457.loritz@fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200410100029.48457.loritz@fh-furtwangen.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mario Loritz <loritz@fh-furtwangen.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mario Loritz wrote:
> Am Samstag, 9. Oktober 2004 14:59 schrieb Florian Schmidt:
> > I don't think this is an alsa error. This is rather a module build error.
> > Make sure your kernel source tree is in a suitable state for building
> > modules against it.
>
> Could you, in short words, explain why alsa-1.0.5 compiles just fine
> and alsa-1.0.6 doesn't?

In 1.0.6, I moved snd_compat_strlcpy() to another module.

It may be possible that you didn't reload the snd-page-alloc module
(usually this is _not_ done by the alsa script).


HTH
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
