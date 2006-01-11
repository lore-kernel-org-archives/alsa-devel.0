From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Wed, 11 Jan 2006 01:30:53 -0600
Message-ID: <2c746f620601102330s337d7744r7b98dad75dbbf374@mail.gmail.com>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
	 <Pine.HPX.4.33n.0510181124030.2094-100000@studcom.urz.uni-halle.de>
	 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
	 <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
	 <1129746748.5203.1.camel@mindpipe>
	 <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/19/05, Eric Shattow <lucent@gmail.com> wrote:
> On 10/19/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > They make a DIFFERENT DEVICE with a DIFFERENT CHIPSET for Mac and
> > Windows?!?  WTF?
> >
> > Lee
> >
>
> Alexander Schussler owns both the Windows and Mac editions of the DJ
> Console hardware. According to his correspondence with
> Hercules/Guillemot representatives, the hardware is identical except
> for improved audio function on the Mac edition. My guess is that the
> Windows edition is first revision, and Mac edition is second revision.
> The firmware is of course completely different between the two
> editions.
>

Anyways, update for everyone.  The ALSA 1.0.10 release doesn't appear
to work with Hercules PC DJ Console (Windows Edition) device. I have
not been able to make it output or record sound.

jnc@baker:~$ arecord -D hw:3 -f S16_LE -c 2 -r 48000 /tmp/test.wav
Recording WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
arecord: xrun:1077: read/write error, state =3D PREPARED

Something like that.  Suggestions, anyone?

 Eric


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
