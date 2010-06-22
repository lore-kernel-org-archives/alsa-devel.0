From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: reading 1 second of audio at a time
Date: Tue, 22 Jun 2010 16:57:41 +0900
Message-ID: <AANLkTimnYRA4_-JIhWLvxgSc9mrqDy1HkQUfzcsq1rSM@mail.gmail.com>
References: <20100621192559.GP15838@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AA0210381A
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 09:57:42 +0200 (CEST)
Received: by vws20 with SMTP id 20so1812975vws.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 00:57:41 -0700 (PDT)
In-Reply-To: <20100621192559.GP15838@belle.intranet.vanheusden.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: folkert <folkert@vanheusden.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 22, 2010 at 4:26 AM, folkert <folkert@vanheusden.com> wrote:
> Hi,
>
> Am trying to achieve something trivial: reading 1 second of audio at a
> time, but something goes wrong:
>
> Sound 1277148008.835094
> Sound 1277148008.838224
> Sound 1277148010.834839
> Sound 1277148010.838001
> Sound 1277148012.834523
> Sound 1277148012.837580
> Sound 1277148014.835240
> Sound 1277148014.838333
>
> As you can see; audio is returned for 2 seconds, then it sleeps 2
> secondsn, then 2 seconds of audio, etc.
That is 'normal' behavior, even though a bit odd (described in the changelog
of the attempted patches)

I submitted patches to make such blocking read/write calls return
as expected, but since they change the semantics of read/write they
were not accepted
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023986.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023985.html

So, you have to write your application around this behavior.
