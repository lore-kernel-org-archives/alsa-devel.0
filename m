From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [ALSA - driver 0000371]: dmix does not work with
 snd-cs46xx driver
Date: Thu, 15 Jul 2004 15:01:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715150143.37ad191c@mango.fruits.de>
References: <20040715121018.7AFE315009@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 53EE0242
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 14:53:56 +0200 (MEST)
In-Reply-To: <20040715121018.7AFE315009@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jul 2004 14:10:18 +0200 (CEST)
noreply@alsa-project.org wrote:

> 
> The following bug has been ASSIGNED.
> ======================================================================
> Summary:                    dmix does not work with snd-cs46xx driver
> Description: 
> When trying to use dmix with the snd-cs46xx driver, no output is produced.
> ======================================================================

Hi,

i also wanted to chime in here with another remark [i seem to be unable to create a mantis account [see end of this message]:

Well, not only does dmix not work with cs46xx, but also dsnoop doesn't work correctly when cs46xx is slave. Like someboy else mentioned on  this list already, the appl_pointers from the corresponding slave devices don't advance [while the hw pointers do]. Symptom for dsnoop: the first recorded buffer after opening the dsnoop pcm is repeated over and over [this is not surprising if none of the pointers advance]. Symptom for dmix: the first buffer is played back over and over which results in silence when the first period of the playback contains silence..

the alsa pcm ladspa plugin doesn't have this problem btw..


Regards,
  Florian Schmidt


----- This is what i get from mantis:

ALSA bugtracking system

Warning: Cannot modify header information - headers already sent by (output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in /srv/www/mantisbt-0.18.3/core/gpc_api.php on line 220

Warning: Cannot modify header information - headers already sent by (output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in /srv/www/mantisbt-0.18.3/core/print_api.php on line 37

Warning: Cannot modify header information - headers already sent by (output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in /srv/www/mantisbt-0.18.3/core/print_api.php on line 39

Warning: Cannot modify header information - headers already sent by (output started at /srv/www/mantisbt-0.18.3/core/html_api.php:139) in /srv/www/mantisbt-0.18.3/core/print_api.php on line 44

-- 
Palimm Palimm!
Sounds/Ware:
http://affenbande.org/~tapas/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
