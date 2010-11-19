From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: nvidia initial sound being skipped
Date: Fri, 19 Nov 2010 12:31:44 +0100
Message-ID: <4CE66020.9090905@ladisch.de>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>	<AANLkTikOc5uwbn4OsKqpvrHUkBzg4k5Wf6YVLNwGm6wH@mail.gmail.com>	<4CE630BC.6030402@ladisch.de>
	<AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 648CD2414C
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 12:30:06 +0100 (CET)
In-Reply-To: <AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Shirley <tephra@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Shirley wrote:
> How would u setup a dmix to play silence?

If you haven't create or modified /etc/asound.conf or ~/.asoundrc,
dmix should be enabled by default.  (If PulseAudio is installed
correctly, PA should be enabled by default.)

Try this to play ten seconds of silence:

  aplay -d 10 -t raw -f dat /dev/zero

To play continuously, omit the "-d 10".


Regards,
Clemens
