From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: simple PCM helper function
Date: Sat, 14 Jan 2006 21:48:17 +0000
Message-ID: <20060114214817.1de4b094.pochini@shiny.it>
References: <Pine.LNX.4.61.0601062102080.10811@tm8103.perex-int.cz>
	<43C28D90.10103@superbug.co.uk>
	<Pine.LNX.4.61.0601101254540.10330@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vsmtp3alice.tin.it (vsmtp3alice.tin.it [212.216.176.143])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 590CA132
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2006 22:48:26 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601101254540.10330@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James@superbug.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jan 2006 13:26:58 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

> You must also add a new function "snd_pcm_check_for_space()" or something
> like this. The app callback will be called from this function. Also, the
> app callback function should probably take same parameters as
> snd_pcm_mmap_begin() handles (areas, offset), because we support more
> ring buffer organization schemes.
>
> So, to all others, is this mechanism worth to implement?

IMHO they should be as simple as possible. I thing the first proposal is
more obvious and straightforward. That callback mechanism just moves the
complexity somewhere else.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
