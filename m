From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core/seq seq_clientmgr.c,1.50,1.51
Date: Mon, 21 Nov 2005 14:19:08 +0100
Message-ID: <m2k6f2dtpv.fsf@vador.mandriva.com>
References: <E1Edprq-0000bY-Gh@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1Edprq-0000bY-Gh@sc8-pr-cvs1.sourceforge.net> (Clemens
	Ladisch's message of "Sun, 20 Nov 2005 06:08:30 -0800")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <cladisch@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <cladisch@users.sourceforge.net> writes:

> Update of /cvsroot/alsa/alsa-kernel/core/seq
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv2283/alsa-kernel/core/seq
> 
> Modified Files:
> 	seq_clientmgr.c 
> Log Message:
> Summary: dynamic minors (5/6): reduce maximum number of MIDI devices per card
> 
> To allow increasing the maximum number of sound cards, we have to limit
> the number of sequencer clients per card because client numbers are
> still allocated statically.
> 
> Reducing the number of clients to four limits the number of sequencer
> MIDI ports to 1024 per card.

defining MAX_MIDI_DEVICES to 4 and using either MAX_MIDI_DEVICES,
(MAX_MIDI_DEVICES-1), or (MAX_MIDI_DEVICES/2-1), ... would be better
instead
 
> Index: seq_clientmgr.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_clientmgr.c,v
> retrieving revision 1.50
> retrieving revision 1.51
> diff -u -r1.50 -r1.51
> --- seq_clientmgr.c	20 Nov 2005 14:06:59 -0000	1.50
> +++ seq_clientmgr.c	20 Nov 2005 14:08:28 -0000	1.51
> @@ -157,7 +157,7 @@
>  				}
>  			}
>  		} else if (clientid >= 64 && clientid < 128) {
> -			int card = (clientid - 64) / 8;
> +			int card = (clientid - 64) / 4;
>  			if (card < snd_ecards_limit) {
>  				if (! card_requested[card]) {
>  					card_requested[card] = 1;
> @@ -2208,12 +2208,12 @@
>  
>  	if (callback == NULL)
>  		return -EINVAL;
> -	if (card && client_index > 7)
> +	if (card && client_index > 3)
>  		return -EINVAL;
>  	if (card == NULL && client_index > 63)
>  		return -EINVAL;
>  	if (card)
> -		client_index += 64 + (card->number << 3);
> +		client_index += 64 + (card->number << 2);
>  
>  	if (down_interruptible(&register_mutex))
>  		return -ERESTARTSYS;



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
