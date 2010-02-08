From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: DMA interrupt not getting triggered(nailed the
	problem need solution)
Date: Mon, 8 Feb 2010 16:06:51 +0000
Message-ID: <ad2655cb1002080806q46eb8828w597112556a4474ef@mail.gmail.com>
References: <15824817.821301265596468706.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id C89B11037F3
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 17:06:53 +0100 (CET)
Received: by fxm3 with SMTP id 3so7559849fxm.19
	for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2010 08:06:51 -0800 (PST)
In-Reply-To: <15824817.821301265596468706.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: anish.singh@samsung.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On 8 February 2010 02:34, ANISH KUMAR <anish.singh@samsung.com> wrote:
>
> Hi All,
>
> This problem is due to ETIMEDOUT(timeout) happening in s3c_snd_lrsync function(called by trigger).
> As i understand this could be due I2S being broken. This basically happens because
> of improper initialization of CPU or CODEC.
>
> But if that is the case then it would not have produced sound initially also but that
> is not the case(initially it is ringing i.e. interrupt coming for a short time then after i am getting time out problem)??
> After this sound is not coming this happens when it does the initialisation again using open,
> prepare,enqueue and so on.
>
> Please provide any pointers which can help me out.
>

Check the master/slave mode at each end of the CPU to CODEC link.
If both are master or both are slave you could see issues similar to
what you are seeing.
