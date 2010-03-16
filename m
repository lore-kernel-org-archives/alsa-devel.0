From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: Configuration help please?
Date: Tue, 16 Mar 2010 10:59:40 -0500
Message-ID: <53baa24a1003160859lcb79c4cpdcf8ceaf1b647e89@mail.gmail.com>
References: <82f04dc41003150711m53b675f6g59c54d142cca77b@mail.gmail.com>
	<82f04dc41003160732i61a35d11r96f38025ee7f0097@mail.gmail.com>
	<53baa24a1003160855v4622bec1g59fceb1fc0907046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 71D072448D
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 16:59:51 +0100 (CET)
Received: by pxi11 with SMTP id 11so11575pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 08:59:50 -0700 (PDT)
In-Reply-To: <53baa24a1003160855v4622bec1g59fceb1fc0907046@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Armbrust <daniel.armbrust.list@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

That is a very complex thing you're asking for. 5.1 sound works by having
mythtv pass the raw datastream out the spdif port. Stereo analog is decoded
by mythtv, so to handle both, you would need mythtv to output the raw stream
to spdif at the same time as it decodes to stereo on analog.

You could have the stream split to two outputs, but the spdif would always
be PCM stereo.

On Mar 16, 2010 9:32 AM, "Dan Armbrust" <daniel.armbrust.list@gmail.com>
wrote:

On Mon, Mar 15, 2010 at 9:11 AM, Dan Armbrust
<daniel.armbrust.list@gmail.com> wrote:
> Hi,
>
> I'm ...
Hello?

Is this really a hard thing that I'm asking to do?  No one can help me
configure alsa?


Thanks,

Dan
_______________________________________________
Alsa-devel mailing list
Alsa-devel@als...
