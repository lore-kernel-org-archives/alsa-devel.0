From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tempo event in a Midi sequencer...
Date: Thu, 21 Jun 2012 08:34:55 +0200
Message-ID: <4FE2C08F.3050307@ladisch.de>
References: <1340223429.16177.YahooMailClassic@web29601.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8A9F11040DE
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 07:13:44 +0200 (CEST)
In-Reply-To: <1340223429.16177.YahooMailClassic@web29601.mail.ird.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ru Vuott <vuott@yahoo.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ru Vuott wrote:
> I have some little problem about changing the metronomic Tempo within a midi song.
> Looking for a solution, I had a look at the code of your Aplaymidi, and I saw this statement:
>
> case 0x51: /* tempo */
>     ......
>     ...etc
>     event->type = SND_SEQ_EVENT_TEMPO;
>     ...etc,
>
> so, I thought that the change of Tempo occur simply by sending an event
> Instead, listening to the midi track, the change does not happen!

Have a look into play_midi; that event must be sent to the system timer port.


Regards,
Clemens
