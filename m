From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Fri, 28 Oct 2005 14:20:30 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Smith <smithbone@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richard Smith wrote:
> I looked through the recient Alsa change logs and found some entries
> that looked liked
>
> usb-audio:
> - Support full speed devices.

The driver has always supported full speed devices; the somewhat
recent changes are for high speed devices (which the Audiophile
isn't).

> I pulled down 2.6.14-rc5 which has alsa 1.0.10rc1 in it and I've had a
> little bit of success.
>
> Out of a clean system boot I can run an 'arecord | aplay' and get
> audio.  However once I start to try and use formats that are >
> 48000kHz and > S16 then I run into trouble and get the  white noise.

What are the contents of /proc/asound/card0/stream0?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
