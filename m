From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: lib version?
Date: Wed, 28 Apr 2004 17:57:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040428175703.pochini@shiny.it>
References: <Pine.HPX.4.33n.0404280901430.7902-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA17800
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2004 17:57:11 +0200
Received: from agnus (agnus.shiny.it [194.20.232.6])
	by denise.shiny.it (8.11.7/8.11.6) with ESMTP id i3SFv1q24627
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2004 17:57:02 +0200
In-Reply-To: <Pine.HPX.4.33n.0404280901430.7902-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 28-Apr-2004 Clemens Ladisch wrote:
> Steve deRosier wrote:
>> Is there any way for a program to query the alsa-lib to determine
>> the version number?
>
> The function snd_asoundlib_version() won't be available before 1.0.5.
> For earlier versions, you can try to test if the symbols listed in
> alsa-lib/src/Versions are available.

On the Amiga all libraries had a version (mandatory by design) and
any file could contain a version string readable with the shell
command "version" just embedding a string with this format:
$VER: thingname v<major>.<minor><sub>
It was a very handy feature :)



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
