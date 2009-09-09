From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
 in prep for ping/pong
Date: Wed, 9 Sep 2009 18:35:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD74F59E@dbde02.ent.ti.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<4AA0113D.9030605@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD74F519@dbde02.ent.ti.com>
	<200909091533.58702.caglarakyuz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <200909091533.58702.caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2009 at 18:03:58, Caglar Akyuz wrote:
> On Wednesday 09 September 2009 15:08:42 Nori, Sekhar wrote:

[...]

> >
> > However, with or without your patch, I noticed a segmentation fault for=
 the
> > first time the 'arecord | aplay' loop is created. There is no fault the
> > second time around. I haven't spent time debugging this yet.
> >
>
> This is due to these lines in davinci_pcm_enqueue_dma:
>
>       data_type =3D prtd->params->data_type;
>       count =3D period_size / data_type;
>
> First time running data_type is set to 0. This is a long time issue, I
> remember modifying my kernels to check for zero before this division..

Ah, thanks! Planning to submit a fix for this? We can work on the patch
if you are busy otherwise.

Regards,
Sekhar
