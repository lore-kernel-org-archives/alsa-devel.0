From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_avail_update returns 0
Date: Thu, 14 Jan 2010 17:29:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001141728170.4324@eeebox2.perex-int.cz>
References: <3baf3d761001140641x41854ecax4012d8342ea22aaf@mail.gmail.com>
	<alpine.LNX.2.00.1001141604100.4324@eeebox2.perex-int.cz>
	<3baf3d761001140717j755c13bbg4f682ac6940911a2@mail.gmail.com>
	<alpine.LNX.2.00.1001141624260.4324@eeebox2.perex-int.cz>
	<3baf3d761001140817y393f0dc3i585da337f26df96f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 94715103905
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 17:29:31 +0100 (CET)
In-Reply-To: <3baf3d761001140817y393f0dc3i585da337f26df96f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Singaravelan Nallasellan <singaravelann@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Jan 2010, Singaravelan Nallasellan wrote:

> Thanks again.
>
> Sorry, I missed to ask you another question.
>
> How does the ring buffer full detected in the core?

For playback: appl_ptr - hw_ptr == ring buffer size.

>> Maybe you can put your code to a public place so we can check it.
>>
> Sure, can I send the complete code to this ml?

No, please. Use http://pastebin.com or something like that and send only 
URL to this list. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
