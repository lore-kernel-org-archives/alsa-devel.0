From: Dan Armbrust <daniel.armbrust.list@gmail.com>
Subject: Re: Configuration help please?
Date: Tue, 16 Mar 2010 11:12:26 -0500
Message-ID: <82f04dc41003160912x2b90a806v6e8fe46c48618172@mail.gmail.com>
References: <82f04dc41003150711m53b675f6g59c54d142cca77b@mail.gmail.com>
	<82f04dc41003160732i61a35d11r96f38025ee7f0097@mail.gmail.com>
	<53baa24a1003160855v4622bec1g59fceb1fc0907046@mail.gmail.com>
	<53baa24a1003160859lcb79c4cpdcf8ceaf1b647e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id CAC2124498
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 17:12:35 +0100 (CET)
Received: by bwz7 with SMTP id 7so120452bwz.4
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 09:12:34 -0700 (PDT)
In-Reply-To: <53baa24a1003160859lcb79c4cpdcf8ceaf1b647e89@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Austin <circuitsoft.alex@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 16, 2010 at 10:59 AM, Alex Austin
<circuitsoft.alex@gmail.com> wrote:
> That is a very complex thing you're asking for. 5.1 sound works by having
> mythtv pass the raw datastream out the spdif port. Stereo analog is decoded
> by mythtv, so to handle both, you would need mythtv to output the raw stream
> to spdif at the same time as it decodes to stereo on analog.
>
> You could have the stream split to two outputs, but the spdif would always
> be PCM stereo.
>

Hmm... or, I have to come up with some plugin configuration that would
cause alsa to decode the raw data, and pass the stereo channels out
the speakers I want... Is that even possible?

No wonder none of the dozens of people I have seen ask this question
on the mailing lists in the past has ever found (or at least posted) a
solution.

Thanks,

Dan
