From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA invoke a Callback ?
Date: Sat, 27 Aug 2011 00:03:27 +0200
Message-ID: <4E58182F.1090801@ladisch.de>
References: <1314385032.22194.YahooMailClassic@web29616.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id ACEF3103813
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 00:03:50 +0200 (CEST)
In-Reply-To: <1314385032.22194.YahooMailClassic@web29616.mail.ird.yahoo.com>
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
> Well, I 'm programming with Gambas 3.0 language. I 'm using
> a GUI.

Use snd_seq_poll_descriptors_count() and snd_seq_poll_descriptors() to
get one or more file descriptors and event masks for the sequencer
device; these file descriptors can be used to wait for events.

When you receive an event, check if the device is actually ready for
reading or writing by calling snd_seq_poll_descriptors_revents().

These functions are designed to be used with poll(); to use them with
Gambas, extract the file descriptors and their event masks from the pfds
array and call GB.Watch() with these values.


Regards,
Clemens
