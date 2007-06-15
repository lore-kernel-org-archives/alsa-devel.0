From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Software mixing according to priority of streams
Date: Fri, 15 Jun 2007 14:59:08 -0400
Message-ID: <75b66ecd0706151159x4974c488ye31e78a63a7fad63@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
	<8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
	<75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
	<8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CB0F24839
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:59:10 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so947137nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:59:09 -0700 (PDT)
In-Reply-To: <8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> A sound server can do this
>
> Maintain a buffer per application ,
> and each buffer will have priority. when data comes on higher priority
> buffer stop taking data from low priority buffer, and configure the
> audio and start pumping data from high priority buffer.

Ah, so you do NOT want software mixing - you want the low priority
stream to stop when the high priority stream starts.

Lee
