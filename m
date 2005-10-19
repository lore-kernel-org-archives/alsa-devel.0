From: Giovanni Maruzzelli <gmaruzz@gmail.com>
Subject: How to hack usbaudio to have more than 8 devices?
Date: Wed, 19 Oct 2005 11:02:30 +0200
Message-ID: <7b197bef0510190202g50208a58x61e72ef7d7018ee8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, clemens@ladisch.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, now I understand why I can't have more than 8 usb alsa devices.

Any hints on how I can hack the snd-usb-audio driver so that it
pretends that multiple USB devices are one sound card?

Best regards,

Giovanni


From: Clemens Ladisch <clemens <at> ladisch.de>
Subject: Re: Maximum number of sound devices
Newsgroups: gmane.linux.alsa.devel
Date: 2005-08-15 07:50:57 GMT (9 weeks, 2 days, 1 hour and 2 minutes ago)

> Robert Dunn wrote:
> > What is the maximum number of capture devices ALSA supports?

ALSA supports up to 8 sound cards, and up to 8 devices on one sound
card.  (It's possible to increase the latter number by using
subdevices.)

It may be possible to hack the snd-usb-audio driver so that it
pretends that multiple USB devices are one sound card.

James Courtier-Dutton wrote:
> The default is 8, but it can be changed with a module option for module
> "snd"

But it cannot be increased beyond 8 (as long as ALSA uses static
device number allocation for its 8-bit minor numbers).

Regards,
Clemens



On 10/18/05, Giovanni Maruzzelli <gmaruzz@gmail.com> wrote:
> Dear Takashi,
>
> first of all, thank you for the great job!
>
> I would like to ask you why are allowed only 8 usbaudio devices.
>
> I would like to use many many more, maybe 64 or 127, just for 8 khz
> 8bit pcm (a telephony app).
>
> Can I implement a workaround, maybe modifying the usbaudio or alsa core?
>
> Can you give me some hints, or point me to the relevant Alsa code ?
>
> Thank you again,
>
> Giovanni
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
