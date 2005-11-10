From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Patch 02/20] V4L (930) Alsa fixes and improvements
Date: Thu, 10 Nov 2005 15:59:47 -0500
Message-ID: <1131656388.8383.182.camel@mindpipe>
References: <1131656168.6478.39.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131656168.6478.39.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, video4linux-list@redhat.com, Ricardo Cerqueira <v4l@cerqueira.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-11-10 at 18:50 -0200, mchehab@brturbo.com.br wrote:
> -       struct saa7134_dev *dev = (struct saa7134_dev*) dev_id;
> +       snd_card_saa7134_t *saa7134 = dev_id;
> +       struct saa7134_dev *dev = saa7134->saadev; 

Don't use typedefs for stucts.  Yes, it's all over the place in ALSA,
but this will be changed very soon.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
