From: Anders Torger <torger@ludd.luth.se>
Subject: Re: How to get information for a busy device?
Date: Mon, 12 Aug 2002 20:27:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208121827.g7CIRd727099@d1o1116.telia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from maile.telia.com (maile.telia.com [194.22.190.16])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA06696
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 20:27:45 +0200
Received: from d1o1116.telia.com (d1o1116.telia.com [213.67.208.241])
	by maile.telia.com (8.12.5/8.12.5) with ESMTP id g7CIRdHp011163
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 20:27:43 +0200 (CEST)
Received: from there (h226n2fls34o1116.telia.com [217.209.23.226])
	by d1o1116.telia.com (8.10.2/8.10.1) with SMTP id g7CIRd727099
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 20:27:39 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 12 August 2002 20.23, you wrote:
> I'd like to be able to get the minimum period size for a pcm device,
> so then I use snd_pcm_hw_params_get_period_size_min(), however, that
> (of course) needs a pcm as the first argument.

Uh... I meant snd_pcm_hw_params_t of course, but to get that, one needs 
the pcm (I suppose).

> In my application it would be good if it was possible to get this
> information, even if the device in question is busy or temporarily
> cannot be accessed by some other reason, causing snd_pcm_open to
> fail.
>
> Is this possible to do in some way?
>
> /Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
