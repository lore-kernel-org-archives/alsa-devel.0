From: Frank.Uepping@t-online.de (FAU)
Subject: Re: dir parameter
Date: Thu, 18 Jul 2002 20:06:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3703A2.6859C793@t-online.de>
References: <200207181720.TAA10994@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com [194.25.134.19])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA11555
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2002 20:07:01 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

> >some functions take an int parameter called dir (e.g.:
> >snd_pcm_hw_params_set_rate()).
> >What is the meaning of that parameter?
>
> its to let you know if the actual value set is above, below or equal
> to the one you asked for.
>
> --p

But how could this be in this case:
int snd_pcm_hw_params_set_rate(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
unsigned int val, int dir);
dir is not a pointer?

By the way, my impression was that only functions with _near postfix are allowed

to choose a value
different to the requested one?

/FAU




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
