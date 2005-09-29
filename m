From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Thu, 29 Sep 2005 15:17:59 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509291514120.4499-100000@studcom.urz.uni-halle.de>
References: <2c746f6205092906046546188c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f6205092906046546188c@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eric Shattow wrote:
> I tried the above patch, and applied it to debian alsa-source package
> 1.0.9b4, and now the DJ Console is recognized.
>
> However, using amidi -d -p hw:2,0,n  does not yield any output when
> moving the controls.

Probably the devices user a different protocol than I was assuming.
Please uncomment the DUMP_PACKETS line near the top of usbmidi.c and
show any "received packet" lines that end up in the system log.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
