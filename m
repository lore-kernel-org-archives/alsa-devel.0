From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: nvidia initial sound being skipped
Date: Tue, 23 Nov 2010 09:49:36 +0100
Message-ID: <4CEB8020.7090904@ladisch.de>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>	<AANLkTikOc5uwbn4OsKqpvrHUkBzg4k5Wf6YVLNwGm6wH@mail.gmail.com>	<4CE630BC.6030402@ladisch.de>	<AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>	<4CE66020.9090905@ladisch.de>	<AANLkTikfGndjp4wdjREzijV0jdTD_B=Tib-OmxK3QWaX@mail.gmail.com>	<4CEA2183.1050408@ladisch.de>
	<AANLkTi=NPMY3r+=USgv4zeHTe1wjV2uzSGOS4v4fpxbv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D4EE424420
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:47:24 +0100 (CET)
In-Reply-To: <AANLkTi=NPMY3r+=USgv4zeHTe1wjV2uzSGOS4v4fpxbv@mail.gmail.com>
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
> Does that mean that dmix/alsa doesn't introduce or loose any bits when
> the input rate matches the output rate?

In that case, the resample plugin is skipped.


Regards,
Clemens
