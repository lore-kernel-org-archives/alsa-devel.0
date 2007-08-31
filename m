From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: ALSA 1.0.15rc1
Date: Fri, 31 Aug 2007 12:02:12 +0200
Message-ID: <m2tzqghviz.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ECE4103833
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 12:02:14 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz> (Jaroslav
	Kysela's message of "Fri\, 31 Aug 2007 11\:14\:20 +0200 \(CEST\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> Hi all,
> 
> 	ALSA 1.0.15rc1 packages are released. Please, check 
> http://www.alsa-project.org for download and changelog.
> 
> 						Jaroslav

Looks like you included the 1.0.14 changelog too. Eg, below shouldn't
have you killed everythinkg after "release 1.0.14a"?

http://www.alsa-project.org/main/index.php/Changes_v1.0.14_v1.0.15rc1#alsa-lib


[edit]alsa-lib
[edit]Core
 Fix plugin directory 
 Properly disable -Bsymbolic-functions if ld doesn't support 
 release 1.0.14a 
 Fix the build of lfloat plugin 
 release 1.0.14 
 Fix undefined references in namehint.c 
 Create asoundlib.h dynamically according to configure options 
 Fix a typo in configure script 
 Continue build even if python-config doesn't exist 
 mixer simple basic abstraction - added python binding 
 Split mmap-emulation code from hw layer
