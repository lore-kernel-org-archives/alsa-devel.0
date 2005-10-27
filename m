From: Richard Smith <smithbone@gmail.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Thu, 27 Oct 2005 12:56:48 -0500
Message-ID: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
References: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
	 <Pine.HPX.4.33n.0510270958560.2999-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0510270958560.2999-100000@studcom.urz.uni-halle.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I looked through the recient Alsa change logs and found some entries
that looked liked

usb-audio:
- Support full speed devices.

Since the Audiophile USB will run at 24/96k and thats where I'm trying
to use it at I figure thats probally a good thing to have supported.

I pulled down 2.6.14-rc5 which has alsa 1.0.10rc1 in it and I've had a
little bit of success.

Out of a clean system boot I can run an 'arecord | aplay' and get
audio.  However once I start to try and use formats that are >
48000kHz and > S16 then I run into trouble and get the  white noise.

Once this happens I have to reboot to recover and sometimes I have to
power cycle to recover.

Often its not enough to just to power cycle and replug the Audiophile
which sometimes causes kernel oopses.

Sometimes I have to power cycle the host to get back to working audio.
 So it seems there may also be issues with my host controller.  Its
Via but  I've fogotten the exact chipset.   I'll post a lspci tonight
if needed.

Its the only device on the USB chain.  I suppose I could use a usb
mouse or something else to check and see if the host is totally broken
or just broken for the Audiophile.

What kind of debugging can I enable to help track this down?

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
