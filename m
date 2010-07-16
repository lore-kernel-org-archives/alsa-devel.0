From: Raffaele Recalcati <lamiaposta71-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: soc-core: soc_pcm_ops dynamically allocated
Date: Fri, 16 Jul 2010 17:25:19 +0200
Message-ID: <AANLkTimcJ4K6hZU__gAUUwOh4ypBP7eOycz9fUTwyEQQ@mail.gmail.com>
References: <1279291619-5081-1-git-send-email-lamiaposta71@gmail.com>
	<1279291619-5081-2-git-send-email-lamiaposta71@gmail.com>
	<20100716150948.GA23183@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1084000180=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20100716150948.GA23183-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============1084000180==
Content-Type: multipart/alternative; boundary=005045015d13aba7b6048b82d31b

--005045015d13aba7b6048b82d31b
Content-Type: text/plain; charset=ISO-8859-1

2010/7/16 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

> On Fri, Jul 16, 2010 at 04:46:57PM +0200, Raffaele Recalcati wrote:
>
> >     If soc_pcm_ops is statically allocated, more than one call to
> soc_new_pcm
> >     cause operations overwrite. The problem is overcome usyng dynamic
> >     allocation.
>
> As I said previously you're looking for Liam's multi-component work
> here rather than this (or at least should be basing your work off his).
>

ok.
For us it is better to have also more feedback from you about the other two
patches.
So the next patchset we'll submit shall be more complete.

Thx

--005045015d13aba7b6048b82d31b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/7/16 Mark Brown <span dir=3D"ltr">&=
lt;<a href=3D"mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org">broonie@opensourc=
e.wolfsonmicro.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); =
padding-left: 1ex;">
<div class=3D"im">On Fri, Jul 16, 2010 at 04:46:57PM +0200, Raffaele Recalc=
ati wrote:<br>
<br>
&gt; =A0 =A0 If soc_pcm_ops is statically allocated, more than one call to =
soc_new_pcm<br>
&gt; =A0 =A0 cause operations overwrite. The problem is overcome usyng dyna=
mic<br>
&gt; =A0 =A0 allocation.<br>
<br>
</div>As I said previously you&#39;re looking for Liam&#39;s multi-componen=
t work<br>
here rather than this (or at least should be basing your work off his).<br>
</blockquote></div><br>ok.<br>For us it is better to have also more feedbac=
k from you about the other two patches.<br>So the next patchset we&#39;ll s=
ubmit shall be more complete.<br><br>Thx<br><br>

--005045015d13aba7b6048b82d31b--

--===============1084000180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1084000180==--
