From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: HG -> GIT migration
Date: Thu, 22 May 2008 10:16:26 +1200
Message-ID: <200805221016.27143.linux@audioscience.com>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F30E245BB
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 00:15:36 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K1800L55OHVIE00@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 May 2008 10:15:32 +1200 (NZST)
In-reply-to: <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
Content-disposition: inline
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

On Wednesday 21 May 2008 18:09:17 you wrote:
> It's not required to set ALSAKERNELDIR to ../alsa-kmirror - it's default
> now.

Without it I get this:

cd alsa-driver/
eliot@zaphod:~/src/alsagit/alsa-driver$ ./gitcompile
No alsa-kernel is found.
Please specify the correct location via ALSAKERNELDIR environment variable.


Looking at gitcompile script it doesn't mention alsa-kmirror

Meanwhile I will avoid the error by specifying the cards I'm interested in.

--
Eliot
