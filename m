From: stan <stanl@cox.net>
Subject: Re: compilation faillure
Date: Fri, 31 Aug 2007 10:14:00 -0700
Message-ID: <46D84C58.8090800@cox.net>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>	<m2lkbrj3gd.fsf@vador.mandriva.com>	<Pine.LNX.4.61.0708311452050.7587@tm8103.perex-int.cz>
	<m2veavhlt5.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao103.cox.net (fed1rmmtao103.cox.net [68.230.241.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 90D192434B
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 19:14:02 +0200 (CEST)
In-Reply-To: <m2veavhlt5.fsf@vador.mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:
> Jaroslav Kysela <perex@suse.cz> writes:
>
>   
>> Oops, configure script does not detected location of python C header files. 
>> Fixed in HG.
>>
>> You may disable building of python code with --disable-python and wait for 
>> 1.0.15rc2.
>>     
>
> --disable-python has no effect
> --disable-python &  --enable-python breaks at the exact same point...
> _______________________________________________
>
>   
Hi,

When I compile the snapshots on Fedora they fail with python errors 
unless I go to the /usr/include directory and create a symbolic link: ln 
-s python2.5 python
i.e. create a generic python link to the version specific include 
directory.  Your system might need something similar.
