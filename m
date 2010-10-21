From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] wm1133-ev1: fix init for
	multimachine	kernel
Date: Fri, 22 Oct 2010 00:19:31 +0200
Message-ID: <4CC0BC73.8070709@eukrea.com>
References: <1287696915-10392-1-git-send-email-eric@eukrea.com>
	<20101021215840.GF30466@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 63.mail-out.ovh.net (63.mail-out.ovh.net [91.121.185.56])
	by alsa0.perex.cz (Postfix) with SMTP id 9212F103AB3
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 00:19:33 +0200 (CEST)
In-Reply-To: <20101021215840.GF30466@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Le 21/10/2010 23:58, Mark Brown a =E9crit :
> On Thu, Oct 21, 2010 at 11:35:15PM +0200, Eric B=E9nard wrote:
>
>> +	if (!machine_is_mx31ads())
>> +		/* return happy. We might run on a totally different machine */
>> +		return 0;
>> +
>
> This is not a sufficient check, we may be running on an mx31ads with a
> different PMIC module.

in which case the current code would also fail ;-)

I don't have such a board but actual code triggers the error log when runni=
ng =

the kernel on my board so I'm open to your suggestion for a better fix.

Thanks,
Eric
