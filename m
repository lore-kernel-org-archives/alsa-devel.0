From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Re: AIC23 on i2C
Date: Thu, 12 May 2005 10:10:53 -0400
Message-ID: <a0580c510505120710116f47dd@mail.gmail.com>
References: <a0580c510505111145101242a0@mail.gmail.com>
	 <20050511225901.GQ20090@trinity.fluff.org>
Reply-To: Eduardo Bezerra <edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050511225901.GQ20090@trinity.fluff.org>
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
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Ben Dooks,


    I looked at the mailing list archives, and the only patch that I saw
was one posted by you:

http://sourceforge.net/mailarchive/message.php?msg_id=3D11168389

    But, the message contains only a partial patch. Could you help me?
    And, you said:=20

The only problem
is there is no standard interface for the attaching of IIS based
codecs to ALSA drivers, unlike AC97.

   Is the driver working?


Thanks for your help.


Eduardo Bezerra Valentin

2005/5/11, Ben Dooks <ben-alsa@fluff.org>:
> On Wed, May 11, 2005 at 02:45:09PM -0400, Eduardo Bezerra wrote:
> > Hi folks,
> >
> >
> >
> >  I need to know if there is any driver to AIC23 on I2C written on ALSA.
> >
> > If there isn't, I want to know how can I get documentation to do this
> > task, because
> > the how-to that I found on
> > http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
> >
> > shows only how to write a pci driver.
>=20
> I've got a tlv320aic23 driver done with the s3c2410 audio system
> (see patches submitted to the list a while ago). The only problem
> is there is no standard interface for the attaching of IIS based
> codecs to ALSA drivers, unlike AC97.
>=20
> --
> Ben
>=20
> Q:      What's a light-year?
> A:      One-third less calories than a regular year.
>=20
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
