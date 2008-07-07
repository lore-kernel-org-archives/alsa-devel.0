From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: snd_pcm_writei() -last value sustained
Date: Mon, 7 Jul 2008 14:55:32 +0100
Message-ID: <200807071455.32137.gineera@aspect135.co.uk>
References: <200807040938.53662.gineera@aspect135.co.uk>
	<200807071453.35353.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UBicI6lBkMWgQAw"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 46F7D245CA
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 15:39:23 +0200 (CEST)
In-Reply-To: <200807071453.35353.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_UBicI6lBkMWgQAw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 07 July 2008 14:53, I wrote:
> The attached shot shows existing sine data in the space, except for the
> last-but-one sample being zero, and shows that the output ends up at zero.

(snip)

> Actually, I've attached the shot to subsequent email in case it would cause
> this email to be blocked.

Attached here.

Alan

--Boundary-00=_UBicI6lBkMWgQAw
Content-Type: image/png;
  name="Last-but-one-zeroing-pcmex-ice1712.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Last-but-one-zeroing-pcmex-ice1712.png"

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

--Boundary-00=_UBicI6lBkMWgQAw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_UBicI6lBkMWgQAw--
