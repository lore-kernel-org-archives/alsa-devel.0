From: Brad Rubin <brubin@codeaurora.org>
Subject: Sending headset insertion events to user space on
	bootup
Date: Fri, 22 Jul 2011 11:58:42 -0700
Message-ID: <4E29C862.8010208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A635103804
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 20:58:45 +0200 (CEST)
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
Cc: plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I=92m having an issue passing events when a headset is inserted upon =

bootup.  I=92m sending a headset insertion event to user space through =

snd_soc_jack_report, but user space is not yet ready to receive events =

and therefore misses the event.  Since the kernel driver doesn=92t resend =

this event, then there=92s no way for user space to see it.  User space is =

still booting up when the event is sent.

Does anyone know of a solution so user space can receive headset =

insertion events on bootup?

Is is possible to either allow the kernel to postpone sending events =

until user space is ready or to store events in some sort of cache so =

that user space can access them?  Would it be possible to use ALSA to =

store the headset status in a device node?

Thanks,
Brad

-- =

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
