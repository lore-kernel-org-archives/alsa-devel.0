From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Fixes AC3 output on Audigy2 sound cards.
Date: Thu, 24 Mar 2005 22:16:49 +0000
Message-ID: <42433C51.6080500@superbug.co.uk>
References: <423C312E.7010503@superbug.co.uk> <s5hacow4w4b.wl@alsa2.suse.de>	<423F3C05.3010100@superbug.co.uk> <s5hzmwv1jnx.wl@alsa2.suse.de>	<4241D5AB.7050604@superbug.co.uk> <m264zhcfnw.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <m264zhcfnw.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:
> James Courtier-Dutton <James@superbug.co.uk> writes:
> 
> 
>>Did you also apply the patch to the Audigy2.conf file, that goes
>>with this patch? The spdif out routing has changed.
> 
> 
> when did this changed in the driver btw?
> 
> 

1.0.9rc2 needs the changed Audigy2.conf file, otherwise AC3 passthru 
will not work. The DSP code in alsa-driver changed to fix a hardware bug 
in some Creative sound cards,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
