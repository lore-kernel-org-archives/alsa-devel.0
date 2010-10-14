From: lee188@singnet.com.sg
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 16:46:34 +0800 (SGT)
Message-ID: <1287045994.4cb6c36a7f8be@discus.singnet.com.sg>
References: <201010131750.18897.julian@jusst.de>
	<loom.20101014T031422-361@post.gmane.org>
	<2021c8d0-f183-4739-a65c-703f3dfc5073@email.android.com>
Reply-To: lee188@singnet.com.sg
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comsmtp2.singnet.com.sg (comsmtp2.singnet.com.sg
	[165.21.101.75])
	by alsa0.perex.cz (Postfix) with ESMTP id B3976103B28
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 10:46:51 +0200 (CEST)
In-Reply-To: <2021c8d0-f183-4739-a65c-703f3dfc5073@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Alex <lee188@singnet.com.sg>
List-Id: alsa-devel@alsa-project.org

--- Julian Scheel <julian@jusst.de> wrote:
 There may also be
> >a limitation in that the Same EP number cannot be used
> >for both IN and OUT.
> 
> Hm, I'm not sure about this. You think I should move the feedback
> pipe into it's own EP?
> I will recheck the At91SAM7 specs later, to see if I can find a note
> on such a limitation.

Hi Julian,

You might like to refer to this thread:

http://www.avrfreaks.net/index.php?name=PNphpBB2&file=printview&t=88432&start=20

As I have found out, it is not necessary to have the same EP number for IN and OUT for rate feedback to work with a Linux or OSX host.  This may be a requirement for Vista/Win7 hosts though.  We are still doing testing.

Alex
