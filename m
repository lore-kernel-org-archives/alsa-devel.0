From: Guillaume Chazarain <guichaz@yahoo.fr>
Subject: Re: Unhelpful permissions in some /proc files
Date: Mon, 04 Apr 2005 14:24:44 +0200
Message-ID: <4251320C.2040503@yahoo.fr>
References: <424DBAE9.7060208@yahoo.fr> <s5h8y3yde8v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y3yde8v.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>BTW, instead of patching each part, checking S_IWUSR in
>snd_info_register() may an easier solution.  The patch is below.
>  
>
Yes, of course, but I didn't like the fact that it looked like a fix 
done by the callee.
Either snd_info_register() is passed good permissions and it doesn't 
change them,
or its job to set them, then they should not be set before.

The comment in your patch explained exactly what I felt, but anyway, if 
you like
it that way, it's fine for me too.

>+		/* fix up write permission */
>
-- 
Guillaume



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
