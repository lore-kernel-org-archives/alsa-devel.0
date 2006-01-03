From: Harri =?iso-8859-1?Q?J=E4rvi?= <harri.jarvi@ajatus.org>
Subject: Re: snd-usb-audio HP-107 midi broke at 2.6.13 or 2.6.14
Date: Tue, 3 Jan 2006 21:21:32 +0200
Message-ID: <20060103192132.GA3724@novelli>
References: <20060101193407.GA18702@novelli> <1136144495.13079.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1136144495.13079.62.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Harri =?iso-8859-1?Q?J=E4rvi?= <harri.jarvi@ajatus.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 01, 2006 at 14:41:34 -0500, Lee Revell wrote:
> Harri J=E4rvi wrote:
> > usb 2-1: new full speed USB device using ohci_hcd and address 2
> > snd-usb-audio: probe of 2-1:1.0 failed with error -5
> > usbcore: registered new driver snd-usb-audio
> >=20
> > PS. Please Cc me when replying.
>=20
> Please use ALSA CVS to do a binary search ("cvs update -D 2005-11-01
> -A", "cvs update -D 2005-12-01 -A", "cvs update -D 2005-11-15" etc) and
> isolate the exact change that caused the problem.

I'm sorry, I need a bit advice here. I'm not sure how to do this. Should=20
I look at alsa-driver or alsa-kernel?

Is there howto for trying different versions of alsa drivers from CVS? I=20
seem to run into compilation problems and incompatibilities with kernel=20
versions when trying to get different versions from ALSA CVS.

I tried both alsa-driver and alsa-kernel. With alsa-kernel I could=20
confirm that snd-usb-audio works for me at -D 2005-10-01, 2005-11-01,=20
2005-11-15 but I couldn't get it compile at 2005-12-01. Then I started=20
to look at the alsa-driver but I couldn't get that compile. It=20
complained about rejected hunks in patches when patching ../alsa-kernel.

Any pointers on how to do this?

Yours,
Harri


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
