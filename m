From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with setting period time and buffer time.
Date: Tue, 19 Feb 2008 13:42:56 +0100
Message-ID: <47BACED0.9090709@ladisch.de>
References: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>	
	<47BA908B.7040700@ladisch.de>
	<9673d3ac0802190320gab8bb7ara92a27b7f602d28b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 18F3E10388F
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 13:41:13 +0100 (CET)
In-Reply-To: <9673d3ac0802190320gab8bb7ara92a27b7f602d28b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ignacy Kasperowicz <fikufik@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ignacy Kasperowicz wrote:
> But what about buffer_time, why can't I set this time ?

The allowed range of values is hardware dependent, like the period time.
Use snd_pcm_hw_params_set_buffer_time_near().

> Anyway is there a method to play my wave for a specified short time?

Just write the data to the device.

What is the problem?


Regards,
Clemens
