From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: hdsp: silence a sprinft() overflow warning
Date: Fri, 21 Aug 2015 14:25:02 +0300
Message-ID: <20150821112502.GR5610@mwanda>
References: <20150611151434.GE12192@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150611151434.GE12192@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ping?

regards,
dan carpenter

On Thu, Jun 11, 2015 at 06:14:34PM +0300, Dan Carpenter wrote:
> card->shortname is a 32 char string so the sprintf() can theoretically
> overflow.  snd_rawmidi_new() can accept strings up to 64 bytes long.
> 
> I have made the temporay buf[] array 40 bytes long and changed the
> sprintf() to snprintf().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
> index c19e021..c1fe1d3 100644
> --- a/sound/pci/rme9652/hdsp.c
> +++ b/sound/pci/rme9652/hdsp.c
> @@ -1526,7 +1526,7 @@ static struct snd_rawmidi_ops snd_hdsp_midi_input =
>  
>  static int snd_hdsp_create_midi (struct snd_card *card, struct hdsp *hdsp, int id)
>  {
> -	char buf[32];
> +	char buf[40];
>  
>  	hdsp->midi[id].id = id;
>  	hdsp->midi[id].rmidi = NULL;
> @@ -1537,7 +1537,7 @@ static int snd_hdsp_create_midi (struct snd_card *card, struct hdsp *hdsp, int i
>  	hdsp->midi[id].pending = 0;
>  	spin_lock_init (&hdsp->midi[id].lock);
>  
> -	sprintf (buf, "%s MIDI %d", card->shortname, id+1);
> +	snprintf(buf, sizeof(buf), "%s MIDI %d", card->shortname, id + 1);
>  	if (snd_rawmidi_new (card, buf, id, 1, 1, &hdsp->midi[id].rmidi) < 0)
>  		return -1;
>  
