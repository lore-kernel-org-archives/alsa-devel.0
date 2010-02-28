From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 48/66] sound/usb/caiaq/midi.h: Checkpatch
	cleanup
Date: Sun, 28 Feb 2010 11:20:12 +0100
Message-ID: <20100228102012.GH28972@buzzloop.caiaq.de>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
	<1267289508-31031-49-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 22BE2244E9
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 11:20:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267289508-31031-49-git-send-email-andrea.gelmini@gelma.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 27, 2010 at 05:51:29PM +0100, Andrea Gelmini wrote:
> sound/usb/caiaq/midi.h:6: ERROR: "foo* bar" should be "foo *bar"
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  sound/usb/caiaq/midi.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/usb/caiaq/midi.h b/sound/usb/caiaq/midi.h
> index 9d16db0..380f984 100644
> --- a/sound/usb/caiaq/midi.h
> +++ b/sound/usb/caiaq/midi.h
> @@ -3,6 +3,6 @@
>  
>  int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *dev);
>  void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev, int port, const char *buf, int len);
> -void snd_usb_caiaq_midi_output_done(struct urb* urb);
> +void snd_usb_caiaq_midi_output_done(struct urb *urb);
>  
>  #endif /* CAIAQ_MIDI_H */
> -- 
> 1.7.0.90.g251a4
> 
