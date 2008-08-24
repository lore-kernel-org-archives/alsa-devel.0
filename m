From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa-utils,alsa-plugins v1.0.18rc2
Date: Sun, 24 Aug 2008 14:28:45 +0100
Message-ID: <g8rnmd$4q7$1@ger.gmane.org>
References: <Pine.LNX.4.61.0808191352000.21669@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 00EEC24348
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 15:28:56 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXFeJ-0001E9-48
	for alsa-devel@alsa-project.org; Sun, 24 Aug 2008 13:28:55 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2008 13:28:55 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2008 13:28:55 +0000
In-Reply-To: <Pine.LNX.4.61.0808191352000.21669@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello all,
> 
> 	I released alsa-utils and alsa-plugins v1.0.18rc2 packages. The 
> changelog is available here:
> 
> http://www.alsa-project.org/main/index.php/Changes_v1.0.18rc1_v1.0.18rc2


I'm unable to compile alsa-utils 1.0.18rc2.


if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -O2 -g -pipe 
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector 
--param=ssp-buffer-size=4 -MT init_parse.o -MD -MP -MF 
".deps/init_parse.Tpo" -c -o init_parse.o init_parse.c; \
         then mv -f ".deps/init_parse.Tpo" ".deps/init_parse.Po"; else 
rm -f ".deps/init_parse.Tpo"; exit 1; fi
init_parse.c:43:18: error: list.h: No such file or directory 

init_parse.c:92:26: error: init_sysdeps.c: No such file or directory 

init_parse.c:93:31: error: init_utils_string.c: No such file or 
directory
init_parse.c:94:28: error: init_utils_run.c: No such file or directory 

init_parse.c:95:24: error: init_sysfs.c: No such file or directory 



Dodgy tarball?

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
