From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd-usb-audio HP-107 midi broke at 2.6.13 or
	2.6.14
Date: Thu, 05 Jan 2006 15:43:08 -0500
Message-ID: <1136493789.847.35.camel@mindpipe>
References: <20060101193407.GA18702@novelli>
	 <1136144495.13079.62.camel@mindpipe>  <20060103192132.GA3724@novelli>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060103192132.GA3724@novelli>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Harri =?ISO-8859-1?Q?J=E4rvi?= <harri.jarvi@ajatus.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-01-03 at 21:21 +0200, Harri J=E4rvi wrote:
> On Sun, Jan 01, 2006 at 14:41:34 -0500, Lee Revell wrote:
> > Harri J=E4rvi wrote:
> > > usb 2-1: new full speed USB device using ohci_hcd and address 2
> > > snd-usb-audio: probe of 2-1:1.0 failed with error -5
> > > usbcore: registered new driver snd-usb-audio
> > >=20
> > > PS. Please Cc me when replying.
> >=20
> > Please use ALSA CVS to do a binary search ("cvs update -D 2005-11-01
> > -A", "cvs update -D 2005-12-01 -A", "cvs update -D 2005-11-15" etc) a=
nd
> > isolate the exact change that caused the problem.
>=20
> I'm sorry, I need a bit advice here. I'm not sure how to do this. Shoul=
d=20
> I look at alsa-driver or alsa-kernel?

The whole thing (cvs co .).  Much easier than checking out alsa-kernel
and alsa-driver separately.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
