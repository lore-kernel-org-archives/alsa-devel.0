From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pcm buffer size
Date: Tue, 25 May 2004 14:07:40 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405251358540.6093-100000@studcom.urz.uni-halle.de>
References: <E1BSYzY-0004YC-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1BSYzY-0004YC-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicolas H=FCppelsh=E4user wrote:
> I'm using alsa 1.0.4.  How can I get a larger alsa buffer size?

PCM devices have a default maximum buffer size and a maximum maxmimum
buffer size.  For example, in the snd-usb-audio driver, it's 64 KB an=
d
128 KB.

The current value (in KB) can be seen in the file
/proc/asound/cardX/pcmXY/subX/prealloc.  You can change it with

  echo 128 > /proc/asound/card0/pcm0p/sub0/prealloc


In most cases, the maxmimum buffer size is constrained by hardware
limitations, but in the case of snd-usb-audio, it should be safe to
raise this value (look for the call to snd_pcm_lib_preallocate_pages(=
)
in usbaudio.c).


HTH
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
