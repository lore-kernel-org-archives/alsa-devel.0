From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 13:19:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF833B8.8090104@libero.it>
References: <Pine.LNX.4.44.0306241001410.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vsmtp1.tin.it (vsmtp1.tin.it [212.216.176.221])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA28228
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 13:20:00 +0200
In-Reply-To: <Pine.LNX.4.44.0306241001410.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> On Tue, 24 Jun 2003, Joern Nettingsmeier wrote:
> 
> 
> # pre-load the configuration files
> 
> @elisp "
>         (load-conf \"/etc/asound.conf\" 0)
>         (load-conf \"~/.asoundrc\" 0)
> "

I'd suggest a simpler alternative:

- introduce a new type SND_CONFIG_TYPE_SEXP
- change parser to parse as an s-expression what begins with '('

The thing to think about is how to decide appropriate run time of sexp.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
