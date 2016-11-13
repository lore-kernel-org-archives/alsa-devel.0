From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: Make static string arrays
	'const 'char * const []'
Date: Sun, 13 Nov 2016 11:12:14 +0100
Message-ID: <87y40nu1s1.fsf@belgarion.home>
References: <1478956993-10065-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 75FC9266C73
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 11:12:20 +0100 (CET)
In-Reply-To: <1478956993-10065-1-git-send-email-lars@metafoo.de> (Lars-Peter
 Clausen's message of "Sat, 12 Nov 2016 14:23:13 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen <lars@metafoo.de> writes:

> const char * const [] is the preferred type for static string arrays since
> this states explicitly that the individual entries are not going to be
> changed. Due to limitations in the ASoC API it was not possible to use it
> for enum text arrays. Commit 87023ff74 ('ASoC: Declare const properly for
> enum texts') changed this, but most drivers still use 'const char
> * []' as the type for their enum text arrays.
>
> Change these occurrences of 'static * const char * []' to 'static const
> char * const []'.
>
> The conversion was done automatically using the following coccinelle semantic
> patch:
> // <smpl>
> @disable optional_qualifier@
> identifier s;
> @@
>  static
> -const char *
> +const char * const
>  s[] = ...;
> // </smpl>
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Hi,

Could you amend your commit message so that checkpatch doesn't complain anymore
? This being done, looks good to me.

Cheers.

--
Robert
