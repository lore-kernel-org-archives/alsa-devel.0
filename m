From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: can't figure out how to send events via alsa_seq
Date: Thu, 29 Dec 2005 17:30:50 +0100
Message-ID: <20051229173050.342bfec6@mango.fruits.de>
References: <20051229172834.596572c0@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B9B9D193
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 17:30:50 +0100 (MET)
In-Reply-To: <20051229172834.596572c0@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Dec 2005 17:28:34 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> But when i hook up the created ports to some softsynth or even a midi
> monitor app i don't get anything. No event is ever sent. I must be
> missing something obvious, so please enlighten me (i don't need
> any steenking queue's i just want to send a midi event _now_ ):

Ahh, damn, i forgot to use snd_seq_ev_set_subs(). Now it works.. hmm..

Flo


-- 
Palimm Palimm!
http://tapas.affenbande.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
