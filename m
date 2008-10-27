From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: Request for test (1.0.18 final)
Date: Mon, 27 Oct 2008 14:25:44 -0500
Message-ID: <490615B8.8070707@gmail.com>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<4905F6EB.8080507@gmail.com>
	<Pine.LNX.4.61.0810271917110.12044@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id DB66A24158
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 20:25:57 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so1064544ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 12:25:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0810271917110.12044@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 27 Oct 2008, Chris Pemberton wrote:
>
>   
>> /home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/../alsa-kernel/core/jack.c:108: 
>> error: 'SW_LINEOUT_INSERT' undeclared (first use in this function)
>>     
>
> Could you try again latest snapshot? I just included the patch which 
> should fix this issue.
>
> 					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>
>   
Alsa-driver compiles fine now; as does alsa-lib. 

I've moved on to testing alsa-utils and I'm getting the following error:


I/O error : Attempt to load network entity 
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
warning: failed to load external entity 
"http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
compilation error: file /tmp/xmlto-xsl.FIhlna line 4 element import
xsl:import : unable to load 
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
make[2]: *** [alsactl_init.7] Error 1
make[2]: Leaving directory 
`/home/cjpembo/LatestALSA/alsa-utils-1.0.18rc3.5.gd7f90/alsactl'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory 
`/home/cjpembo/LatestALSA/alsa-utils-1.0.18rc3.5.gd7f90/alsactl'
make: *** [install-recursive] Error 1

I have internet connectivity, so that shouldn't be the problem.  In 
addition, I can download the file OK using wget:

wget http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl

Chris
