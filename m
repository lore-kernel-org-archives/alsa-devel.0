From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Buffering issues 2
Date: Sat, 3 May 2008 21:12:19 -0400
Message-ID: <75b66ecd0805031812o30684484u8cf99729467ffe30@mail.gmail.com>
References: <20080424011833.GA28905@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E38B24628
	for <alsa-devel@alsa-project.org>;
	Sun,  4 May 2008 03:12:21 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so442401rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 03 May 2008 18:12:20 -0700 (PDT)
In-Reply-To: <20080424011833.GA28905@tango.0pointer.de>
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 23, 2008 at 9:18 PM, Lennart Poettering <mznyfn@0pointer.de> wrote:
>  The happens to be configured to 2 periods. So even if _avail_update()
>  has some kind of period granularity (?) it should always have told us
>  after we come back from the sleeping that at least *one* period is
>  free. But it said 0 frames. Nada. Rien. Nichts. Kaputt.

Should we just disallow 2 periods per buffer on HDA intel?  I've never
heard of it working for anyone on the JACK and linux audio user lists
with less than 3.

Lee
