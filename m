From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Tue, 01 Jul 2008 15:12:22 -0700
Message-ID: <486AABC6.6020906@cox.net>
References: <3B6F5C9068D5864096EB291236C3386F02CE1628@xmb-sjc-21d.amer.cisco.com>
	<486A384B.6090103@cox.net>
	<3B6F5C9068D5864096EB291236C3386F03B35428@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao101.cox.net (fed1rmmtao101.cox.net [68.230.241.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 98D132446B
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 00:12:24 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F03B35428@xmb-sjc-21d.amer.cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mitul Sen (misen)" <misen@cisco.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mitul Sen (misen) wrote:
>
> Thanks for your suggestions. For the first suggestion, how would I 
> know the version of alsa-lib that I am using so that I can download 
> the source code for the same? Is alsa-lib the same as libasound? Under 
> /usr/lib/libasound.so I have a symbolic link to libasound.so.2.0.0. Is 
> that then the version I should be looking for?
>
> I am really new to this so please excuse me if these questions are too 
> basic for this forum!
>
> Thanks,
> Mitul
>
Good queston.  I know because of the package.  You can find the driver 
version by running    cat  /proc/asound/version    and the utilities 
version by running   aplay --version   .
I couldn't find a way to get the library version.  You can use the run 
   alsa-info.sh --no-upload     and the output will have the driver, 
library, and tool version at the top.
The script is found at http://www.alsa-project.org/alsa-info.sh

libasound is always version 2.0.0, no matter the alsa-lib version.  I 
presume that is to facilitate testing and upgrading.  Nothing will break 
with newer versions.  So that is unrelated to alsa version.

You can find the latest beta versions of all the alsa source here  

http://www.alsa-project.org/main/index.php/Changes_v1.0.17rc2_v1.0.17rc3

And a link to the latest stable release here
http://www.alsa-project.org 
