From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: Re: alsa-driver-1.0.6a unresolved symbol [SOLVED]
Date: Fri, 15 Oct 2004 17:27:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410151727.02831.loritz@fh-furtwangen.de>
References: <Pine.HPX.4.33n.0410111356480.8356-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0410111356480.8356-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
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

Am Montag, 11. Oktober 2004 13:58 schrieb Clemens Ladisch:

> In 1.0.6, I moved snd_compat_strlcpy() to another module.
>
> It may be possible that you didn't reload the snd-page-alloc module
> (usually this is _not_ done by the alsa script).
>
>
> HTH
> Clemens

It was exactly that problem. Thank you!

Greetings,
Mario



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
